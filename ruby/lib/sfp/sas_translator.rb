# 07-01-2013
# - disable removing "immutable" variables because the method has bugs
# - allow using "parent" in reference of constraint or effect
#
# 31-10-2012
# - rename primitive types: $.Boolean, $.Integer, $.String
# - set SFp to only recognise integer value
# - enable primitive type as procedure's parameter
#
# 14-10-2012
# - find and reduce the domain of immutable variables
#
# 12-10-2012
# - support CLASS enumerator
#
# 01-09-2012
# - support IN/NOT-IN SET constraint
# - support ARRAY data-structure, index operator
#
# 29-08-2012
# - support EQUALS, NOT-EQUALS, AND, OR, IF-THEN constraints
#
# 23-08-2012
# - grounding procedure's parameters to produce operator
# - normalize and apply global constraint to all operators
#
# 01-07-2012
# - collecting classes and variables
# - foreach subclasses, inherits attributes and procedures from superclass
# - foreach objects, inherits attributes and procedures from class

require 'benchmark'

module Sfp

	class TranslationException < Exception; end

	# include 'Sas' module to enable processing Sfp into Finite-Domain Representation (FDR)
	#
	# TODO:
	# - nested reference on right-side statement (value of EQUALS/NOT-EQUALS)
	# - a first-order logic formula
	# - enumeration of values of particular type
	# - SET abstract data-type, membership operators
	module SasTranslator
		GlobalOperator = '-globalop-'
		GlobalVariable = '_global_var'
		SometimeOperatorPrefix = '-sometime-'
		SometimeVariablePrefix = '-sometime-'
		GoalOperator = '-goal-'
		GoalVariable = '-goal-'

		GlobalConstraintMethod = 1 # 1: proposed method, 2: patrik's, 3: concurrent-actions
		ActivateSimpleGlobalConstraint = false #true

		attr_accessor :root
		attr_reader :variables, :types, :operators, :axioms, :goals, :benchmarks

		def to_sas
			self.compile_step_1
			self.compile_step_2
			return self.sas
		end

		def compile_step_2
			@benchmarks['postprocessing simple global constraint'] = Benchmark.measure do
				self.postprocess_simple_global_constraint
			end
		end

		def compile_step_1
			begin
				@benchmarks = {}
				@unknown_value = ::Sfp::Unknown.new

				@arrays = Hash.new
				if @parser_arrays != nil
					@parser_arrays.each do |k,v|
						first, rest = k.explode[1].explode
						next if rest == nil
						@arrays['$.' + rest.to_s] = v
					end
				end

				return nil if @root == nil
				return nil if not @root.has_key?('initial') or not @root.has_key?('goal')

				@variables = Hash.new
				@types = { '$.Boolean' => [true, false],
					'$.Integer' => Array.new,
					'$.String' => Array.new
				}
				@operators = Hash.new
				@axioms = Array.new

				@g_operators = []

				# collect classes
				#self.collect_classes
			
				# unlink 'initial', 'goal', 'global' with root
				@root['initial'].delete('_parent')
				@root['goal'].delete('_parent')
				if @root['goal'].has_key?('always')
					@root['global'] = @root['goal']['always']
					@root['goal'].delete('always')
					@root['global']['_self'] = 'global'
					@root['global']['_type'] = 'and'
				end
				@root['global'].delete('_parent') if @root.has_key?('global')

				if @root['goal'].has_key?('sometime')
					@root['sometime'] = @root['goal']['sometime']
					@root['goal'].delete('sometime')
					@root['sometime']['_type'] = 'or'
					@root['sometime'].delete('_parent')
				end

				if @root['goal'].has_key?('sometime-after')
					@root['sometime-after'] = @root['goal']['sometime-after']
					@root['goal'].delete('sometime')
					@root['sometime-after'].delete('_parent')
				end

			@benchmarks['generating variables'] = Benchmark.measure do
				@root['initial'].accept(Sfp::Visitor::ReferenceModifier.new)
				@root['goal'].accept(Sfp::Visitor::ReferenceModifier.new) if @root.has_key?('goal')
				@root['global'].accept(Sfp::Visitor::ReferenceModifier.new) if @root.has_key?('global')
				#@root['sometime'].accept(ReferenceModifier.new)
				#@root['sometime-after'].accept(ReferenceModifier.new)

				### collect variables ###
				@root['initial'].accept(VariableCollector.new(self))

				### collect values ###
				# collect values from goal constraint
				value_collector = Sfp::SasTranslator::ValueCollector.new(self)
				@root['goal'].accept(value_collector) if @root.has_key?('goal') and
						@root['goal'].isconstraint
				# collect values from global constraint
				@root['global'].accept(value_collector) if @root.has_key?('global') and
						@root['global'].isconstraint
				# collect values from sometime constraint
				@root['sometime'].accept(value_collector) if @root.has_key?('sometime')

				# remove duplicates from type's set of value
				#@types.each_value { |values| values.uniq! }
				@types.keys.each { |type| @types[type] = to_set(@types[type]) }

				# set domain values for each variable
				self.set_variable_values

				# identify immutable variables
				#self.identify_immutable_variables

				# re-evaluate set variables and types
				self.evaluate_set_variables_and_types
			end

			@benchmarks['processing goal'] = Benchmark.measure do
				### process goal constraint ###
				process_goal(@root['goal']) if @root.has_key?('goal') and
						@root['goal'].isconstraint
			end

			@benchmarks['processing global constraint'] = Benchmark.measure do
				### process global constrait
				self.process_global_constraint
			end

			@benchmarks['processing sometime constraint'] = Benchmark.measure do
				### normalize sometime formulae ###
				if @root.has_key?('sometime')
					raise TranslationException, 'Invalid sometime constraint' if
						not normalize_formula(@root['sometime'])
				end
			end

			@variables.each_value do |var|
				if !var.index(var.init)
					var << var.init
					@types[var.type] << var.init
				end
				if !var.goal.nil? and !var.index(var.goal)
					var << var.goal
					@types[var.type] << var.goal
				end
			end
			@types.keys.each { |type| @types[type] = to_set(@types[type]) }

			# add Sfp::Unknown and Sfp::Undefined value to all non-final variables
			self.add_unknown_undefined_value_to_variables

			@benchmarks['processing procedures'] = Benchmark.measure do
				### process all procedures
				@variables.each_value do |var|
					if var.is_final
						var.init.each { |k,v| process_procedure(v, var.init) if v.is_a?(Hash) and v.isprocedure }
					end
				end
				self.reset_operators_name
			end

				### process sometime modalities ###
				self.process_sometime if @root.has_key?('sometime')
				### process sometime-after modalities ###
				self.process_sometime_after if @root.has_key?('sometime-after')

				# detect and merge mutually inclusive operators
				self.search_and_merge_mutually_inclusive_operators

				#self.add_unknown_value_to_nonstatic_variables

				#self.dump_types
				#self.dump_vars
				#self.dump_operators

				@vars = @variables.values

			rescue Exception => e
				raise e
			end
		end

		def to_set(array)
			array.inject([]) { |result,item| result << item unless result.include?(item); result }
		end

		def variable_name_and_value(var_id, value_index)
			i = @vars.index { |v| v.id == var_id }
			var = @vars[i]
			return nil, nil if var.nil?
			return var.name, nil if value_index >= var.length or
			                        value_index < 0
			value = var[value_index]
			if value.is_a?(Hash)
				return var.name, value.ref if value.isobject
				return var.name, nil
			else
				return var.name, value
			end
		end

		def search_and_merge_mutually_inclusive_operators
			return if GlobalConstraintMethod != 3
			last = @g_operators.length-1
			@g_operators.each_index do |i|
				op1 = @g_operators[i]
				for j in i+1..last
					op2 = @g_operators[j]
					next if op1.modifier_id != op2.modifier_id or op1.conflict?(op2)
					next if not (op1.supports?(op2) and op2.supports?(op1))
					if op1.supports?(op2) and op2.supports?(op1)
						op = op1.merge(op2)
						op.modifier_id = op1.modifier_id
						op1 = op
					end
				end
				@operators[op1.name] = op1 if op1 != @g_operators[i]
			end
		end

		def evaluate_set_variables_and_types
			@variables.each_value do |var|
				next if not var.isset
				new_values = []
				var.each { |x| new_values << x['_values'] if x.is_a?(Hash) and x.isset }
				new_values.each { |x| var << x }
				#var.delete_if { |x| x.nil? or x == '' }
				var.delete_if { |x| x.nil? or x == '' or (x.is_a?(Hash) and x.isset) }
				var.each { |x| x.sort! }
				var.uniq!

				var.init = var.init['_values'] if var.init.is_a?(Hash) and var.init.isset
				var.goal = var.goal['_values'] if var.goal.is_a?(Hash) and var.goal.isset
			end

			@types.each do |name,values|
				next if name[0,1] != '('
				new_values = []
				values.each { |x| new_values << x['_values'] if x.is_a?(Hash) and x.isset }
				new_values.each { |x| values << x }
				values.delete_if { |x| x.nil? or x == '' or (x.is_a?(Hash) and x.isset) }
				#values.delete_if { |x| x == nil or x == '' }
				values.each { |x| x.sort! }
				values.uniq!
			end
		end

		# Find immutable variables -- variables that will never be affected with any
		# actions. Then reduce the size of their domain by 1 only i.e. the possible
		# value is only their initial value.
		# BUGGY! -- operator's effects may contain other object's variable
		def identify_immutable_variables
			def is_this(ref)
				ref.length > 7 and (ref[0,7] == '$.this.' or ref[0,7] == '$.self.')
			end

			mutables = {}
			@variables.each_key { |k| mutables[k] = false }
			@variables.each_value do |var|
				next if not var.is_final
				var.init.each do |k1,v1|
					next if k1[0,1] == '_' or
							not v1.is_a?(Hash) or
							not v1.isprocedure
					v1['_effect'].each do |k2,v2|
						next if k2[0,1] == '_' or not k2.isref
						if is_this(k2)
							vname = var.name + k2[6..k2.length-1]
							mutables[vname] = true
						else
							# TODO
						end
					end
				end
			end
			mutables.each do |vname, is_mutable|
				var = @variables[vname]
				if var != nil and not var.is_final and (not is_mutable)
					var.clear
					var << var.init
					var.mutable = false
				end
			end
		end

		#####
		# Method for postprocessing simple global constraints
		#####
		def postprocess_simple_global_constraint
			@operators.keys.each do |name|
				# skip global, sometime, and goal verifier operators
				next if name =~ /\-globalop\-/
				next if name =~ /\-sometime\-/
				next if name =~ /\-goal\-/

				operator = @operators[name]
				@operators.delete(name)

				postprocess_simple_global_constraint_to_operator(operator).each { |op|
					@operators[op.name] = op
				}
			end if @operators.is_a?(Hash)
		end

		def postprocess_simple_global_constraint_to_operator(operator)
			return [operator] if GlobalConstraintMethod == 2

			def enforce_equals_constraint(operator, var, val)
				if operator.has_key?(var)
					return nil if !operator[var].pre.nil? or operator[var].pre != val
					operator[var].pre = val
				else
					operator[var] = Parameter.new(@variables[var], val)
				end
				operator
			end

			if @global_simple_conjunctions.is_a?(Hash)
				# simple conjunction
				@global_simple_conjunctions.each do |var,c|
					if c['_type'] == 'and'
						c.each { |k,v| return [] if enforce_equals_constraint(operator, k, v['_value']).nil? }
					else c['_type'] == 'equals'
						return [] if enforce_equals_constraint(operator, var, c['_value']).nil?
					end
				end
			end

			# return true if precondition supports premise
			def pre_support_premise(operator, premise)
				premise.each { |var,c|
					next if var[0,1] == '_'
					return false if !operator.has_key?(var) or (!operator[var].pre.nil? and operator[var].pre != c['_value'])
				}
				true
			end

			# return true if postcondition supports premise
			def post_support_premise(operator, premise)
				premise.each { |var,c|
					return true if var[0,1] != '_' and operator.has_key?(var) and
						!operator[var].post.nil? and operator[var].post == c['_value']
				}
				false
			end

			def post_threat_conclusion(operator, conclusion)
				conclusion.each { |var,c|
					return true if var[0,1] == '_' and operator.has_key?(var) and
						!operator[var].post.nil? and operator[var].post != c['_value']
				}
				false
			end

			def pre_threat_conclusion(operator, conclusion)
				conclusion.each { |var,c|
					next if var[0,1] == '_'
					return true if !operator.has_key?(var) or (!operator[var].pre.nil? and operator[var].pre != c['_value'])
				}
				false
			end

			return [operator] if not @global_simple_implications.is_a?(Hash)

			@global_simple_implications.each do |id,imply|
				# If the operator's precondition support the premise or
				# if the operator's postcondition support the premise, then
				# it should support the conclusion as well.
				if pre_support_premise(operator, imply['_premise']) or
				   post_support_premise(operator, imply['_premise'])
					imply['_conclusion'].each do |var,c|
						next if var[0,1] == '_'
						if operator.has_key?(var)
							if operator[var].pre.nil? # enforce the operator to support the conclusion
								operator[var].pre = c['_value']
							end
							# this operator's does not support conclusion, then remove it from operators list
							return [] if operator[var].pre != c['_value']
						else
							# enforce the operator to support the conclusion
							operator[var] = Parameter.new(@variables[var], c['_value'])
						end
					end
				end
			end
			
			results = []
			@global_simple_implications.each do |id,imply|
				if pre_threat_conclusion(operator, imply['_conclusion']) or
				   post_threat_conclusion(operator, imply['_conclusion'])
					imply['_premise'].each do |var,c|
						next if var[0,1] == '_'
						@variables[var].not(c['_value']).each do |x|
							op = operator.clone
							if op.has_key?(var)
								if op[var].pre != x
									op[var].pre == x
									results << op
								end
							else
								op[var] = Parameter.new(@variables[var], x)
								results << op
							end
						end
					end
				end
			end
			return [operator] if results.length <= 0
			results
		end

		def preprocess_simple_global_constraint
			return if GlobalConstraintMethod == 2

			def conjunction_only(id, f)
				#return true if @variables.has_key?(id) and f['_type'] == 'equals'
				return true if f['_type'] == 'equals'
				if f['_type'] == 'and'
					f.each { |k,v| return false if k[0,1] != '_' and not conjunction_only(k, v) }
					return true
				end

				false
			end

			def simple_formulae(id, f)
				if f['_type'] == 'imply'
					f.each { |k,v| return false if k[0,1] != '_' and not conjunction_only(k, v) }
					return true
				end
				conjunction_only(id, f)
			end

			global = @root['global']
			simples = global.select { |k,v| k[0,1] != '_' and
				(!k.isref or @variables.has_key?(k)) and
				simple_formulae(k, v)
			}

			@global_simple_conjunctions = {}
			@global_simple_implications = {}
			simples.each do |id,constraint|
				case constraint['_type']
				when 'equals', 'and'
					raise TranslationException, 'Invalid global constraint' if not normalize_formula(constraint)
					@global_simple_conjunctions[id] = constraint
				when 'imply'
					constraint.keys.each { |k|
						next if k[0,1] == '_'
						raise TranslationException, 'Invalid global constraint' if not normalize_formula(constraint[k])
						constraint[k].select { |k,v| k[0,1] != '_' }
						constraint['_premise'] = constraint[k] if constraint[k]['_subtype'] == 'premise'
						constraint['_conclusion'] = constraint[k] if constraint[k]['_subtype'] == 'conclusion'
					}
					@global_simple_implications[id] = constraint
				else
					raise Exception, "Bug: non-simple formulae detected - #{constraint['_type']}"
				end
				global.delete(id)
			end
		end
		##### End of methods for processing simple global constraints #####


		def process_global_constraint
			@total_complex_global_constraints = 0

			### normalize global constraint formula ###
			if @root.has_key?('global') and @root['global'].isconstraint
				preprocess_simple_global_constraint if ActivateSimpleGlobalConstraint

				keys = @root['global'].keys.select { |k| k[0,1] != '_' }
				@total_complex_global_constraints = keys.length

				raise TranslationException, 'Invalid global constraint' if 
						not normalize_formula(@root['global'], true)

				if GlobalConstraintMethod == 1 and @total_complex_global_constraints > 0
					# dummy variable
					@global_var = Variable.new(GlobalVariable, '$.Boolean', -1, false, true)
					@global_var << true
					@global_var << false
					@variables[@global_var.name] = @global_var
					# dummy operator
					eff = Parameter.new(@global_var, false, true)
					if @root['global']['_type'] == 'and'
						op = Operator.new(GlobalOperator, 0)
						op[eff.var.name] = eff
						@operators[op.name] = op
					else
						index = 0
						@root['global'].each do |name,constraint|
							next if name[0,1] == '_'
							map_cond = and_equals_constraint_to_map(constraint)
							op = Operator.new(GlobalOperator + index.to_s, 0)
							op[eff.var.name] = eff
							map_cond.each do |k,v|
								next if k[0,1] == '_'
								raise VariableNotFoundException, k if not @variables.has_key?(k)
								op[@variables[k].name] = Parameter.new(@variables[k], v)
							end
							@operators[op.name] = op
						end
					end
				end
			end
		end

		def process_sometime
			@root['sometime'].each do |k,v|
				next if k[0,1] == '_'
				# dummy-variable
				var = Variable.new(SometimeVariablePrefix + k, '$.Boolean', -1, false, true)
				var << true
				var << false
				@variables[var.name] = var
				# dummy-operator
				op = Operator.new(SometimeOperatorPrefix + k, 0)
				eff = Parameter.new(var, false, true)
				op[eff.var.name] = eff
				map = and_equals_constraint_to_map(v)
				map.each { |k1,v1|
					op[@variables[k1].name] = Parameter.new(@variables[k1], v1, nil)
				}
				@operators[op.name] = op
			end
		end

		def process_sometime_after
			# TODO
			@root['sometime-after'].each do |k,v|
				next if k[0,1] == '_'
				# dummy-variable
				var = Variable.new('sometime_after_' + k, '$.Boolean', -1, true, true)
				var << true
				var << false
				@variables[var.name] = var
				# normalize formula
				
				# dummy-operator
				op = Operator.new('-sometime_after_activate-' + k, 0)
				eff = Parameter.new(var, true, false)
				op[eff.var.name] = eff
			end
		end

		def process_goal(goal)
			raise TranslationException, 'invalid goal constraint' if not normalize_formula(goal)
			@goals = []
			if goal['_type'] == 'and'
				map = and_equals_constraint_to_map(goal)
				map.each { |name,value|
					var = @variables[name]
					value = @types[var.type][0] if value.is_a?(Hash) and value.isnull
					value = @root['initial'].at?(value) if value.is_a?(String) and value.isref
					var.goal = value
					if not var.mutable
						var.init = var.goal
						var.clear
						var << var.init
					end
				}
				@goals << map
			elsif goal['_type'] == 'or'
				count = 0
				var = Variable.new(GoalVariable, '$.Boolean', -1, false, true)
				var << true
				var << false
				@variables[var.name] = var
				eff = Parameter.new(var, false, true)

				goal.each { |k,g|
					next if k[0,1] == '_'
					op = Operator.new("#{GoalOperator}#{count}", 0)
					op[var.name] = eff
					map = and_equals_constraint_to_map(g)
					map.each { |k1,v1|
						var = @variables[k1]
						op[@variables[k1].name] = Parameter.new(@variables[k1], v1, nil)
					}
					@operators[op.name] = op
					@goals << map
				}
			end
		end

		def create_output
			self.to_s
		end

		def dump(stream)
			init = @root['initial']

			# version
			stream.write "begin_version\n3\nend_version\n"
			# metric
			stream.write "begin_metric\n1\nend_metric\n"

			### use symbolic as key in map of variables
			vars = {}
			@variables.each { |k,v| vars[k.to_sym] = v }
			names = vars.keys

			# variables
			stream.write "#{names.length}\n"
			names.sort!
			names.each_index do |i|
				var = vars[ names[i] ]
				var.id = i
				var.dump(stream, init)
			end

			# mutex
			stream.write "0\n"

			# initial & goal state
			stream.write "begin_state\n"
			goal = ''
			goal_count = 0
			names.each do |name|
				var = vars[name]
				if var.init.is_a?(Hash) and var.init.isnull
					stream.write "0\n"
				elsif var.init.is_a?(::Sfp::Unknown)
					stream.write "#{var.length - 1}\n"
				else
					val = var.index(var.init).to_s
					raise TranslationException, "Unknown init: #{var.name}=#{var.init.inspect}" if val.length <= 0
					stream.write "#{val}\n"
				end

				if var.goal != nil
					goal << "#{var.id} #{var.index(var.goal)}\n"
					goal_count += 1
				end
			end
			stream.write "end_state\nbegin_goal\n#{goal_count}\n#{goal}end_goal\n"

			# operators
			operators = @operators.values.select { |op| op.total_preposts > 0 }
			stream.write "#{operators.length}\n"
			operators.each { |operator| operator.dump(stream, init, vars) }

			# axioms
			stream.write "0"
		end

		def sas
			# version
			out = "begin_version\n3\nend_version\n"
			# metric
			out << "begin_metric\n1\nend_metric\n"

			benchmarks = {}

			### use symbolic as key in map of variables
			vars = {}
			@variables.each { |k,v| vars[k.to_sym] = v }
			names = vars.keys

			# variables
			out << "#{names.length}\n"
			names.sort!
			names.each_index do |i|
				var = vars[ names[i] ]
				var.id = i
				out << var.to_sas(@root['initial'])
			end

			# mutex
			out << "0\n"

			# initial & goal state
			out << "begin_state\n"
			goal = ''
			goal_count = 0
			names.each do |name|
				var = vars[name]
				if var.init.is_a?(Hash) and var.init.isnull
					out << "0\n"
				elsif var.init.is_a?(::Sfp::Unknown)
					out << "#{var.length - 1}\n"
				else
					val = var.index(var.init).to_s
					raise TranslationException, "Unknown init: #{var.name}=#{var.init.inspect}" if val.length <= 0
					out << "#{val}\n"
				end

				if var.goal != nil
					goal << "#{var.id} #{var.index(var.goal)}\n"
					goal_count += 1
				end
			end
			out << "end_state\nbegin_goal\n#{goal_count}\n#{goal}end_goal\n"

			# operators
			ops = ''
			total = 0
			@operators.each_value do |operator|
				next if operator.total_preposts <= 0
				sas = operator.to_sas(@root['initial'], vars)
				if not sas.nil?
					ops << sas
					total += 1
				end
			end
			out << "#{total}\n"
			out << ops

			# axioms
			out << "0"
		end

		def reset_operators_name
			Sfp::SasTranslator.reset_operator_id
			ops = Hash.new
			@operators.each_value { |op|
				op.id = Sfp::SasTranslator.next_operator_id
				@operators.delete(op.name)
				op.update_name
				ops[op.name] = op
			}
			@operators = ops
		end

		def self.reset_operator_id
			@@op_id = -1
		end

		# return the next operator's id
		def self.next_operator_id
			return (@@op_id += 1) if defined?(@@op_id) != nil
			@@op_id = 0
			return @@op_id
		end

		# return the next constraint's id
		def self.next_constraint_id
			return (@@constraint_id += 1) if defined?(@@constraint_id) != nil
			@@constraint_id = 0
			return @@constraint_id
		end

		def self.next_constraint_key
			return 'constraint_' + next_constraint_id.to_s
		end

		# return the next variable's id
		def self.next_variable_id
			return (@@variable_id += 1) if defined?(@@variable_id) != nil
			@@variable_id = 0
			return @@variable_id
		end
	
		# return the next axiom's id
		def self.next_axiom_id
			return (@@axiom_id += 1) if defined?(@@axiom_id) != nil
			@@axiom_id = 0
			return @@axiom_id
		end


		# process the conditions of an operator and return all possible set
		# of conditions
		def process_conditions(cond)
			map = Hash.new
			cond.each { |k,v|
				next if k[0,1] == '_'
				if v['_type'] == 'equals'
					map[k] = v['_value']
				end
			}
			return map
		end

		def and_equals_constraint_to_map(c)
			return { c['_self'] => c['_value'] } if c['_type'] == 'equals'
			map = {}
			c.each { |k,v| map[k] = v['_value'] if k[0,1] != '_' and v['_type'] == 'equals' }
			return map
		end

		# process the effects of operator and return all possible sets
		# of effects
		def process_effects(eff)
			map = Hash.new
			eff.each { |k,v|
				next if k[0,1] == '_'
				if v['_type'] = 'equals'
					map[k] = v['_value']
				end
			}
			return map
		end

		# process given operator
		def process_operator(op)
			# return if given operator is not valid
			# - method "normalize_formula" return false
			# - there's an exception during normalization process
			begin
				return if not normalize_formula(op['_condition'])
			rescue Exception => exp
				return
			end
			# at this step, the conditions formula has been normalized (AND/OR tree)
			# AND conditions
			if op['_condition']['_type'] == 'and'
				process_grounded_operator(op, op['_condition'], op['_effect'])
			else
				op['_condition'].each { |k,v|
					next if k[0,1] == '_'
					process_grounded_operator(op, v, op['_effect'])
				}
			end
		end

		# process grounded operator (no parameter exists)
		def process_grounded_operator(op, conditions, effects)
			map_cond = and_equals_constraint_to_map(conditions)
			map_eff = and_equals_constraint_to_map(effects)
			keys = map_cond.keys.concat(map_eff.keys)

			# combine map_cond & map_eff if any of them has >1 items
			op_id = Sfp::SasTranslator.next_operator_id
			sas_op = Operator.new(op.ref, op['_cost'])
			sas_op.params = op['_parameters']

			keys.each { |k|
				return if not @variables.has_key?(k)
				pre = (!map_cond.has_key?(k) ? nil : map_cond[k])
				#pre = @root['initial'].at?(pre) if pre.is_a?(String) and pre.isref
				post = (!map_eff.has_key?(k) ? nil : map_eff[k])
				#post = @root['initial'].at?(post) if post.is_a?(String) and post.isref
				sas_op[@variables[k].name] = Parameter.new(@variables[k], pre, post)
			}

			if GlobalConstraintMethod == 1 and @total_complex_global_constraints > 0
				@operators[sas_op.name] = sas_op if apply_global_constraint_method_1(sas_op)
			elsif GlobalConstraintMethod == 2 or GlobalConstraintMethod == 3
				@operators[sas_op.name] = sas_op if apply_global_constraint_method_2(sas_op)
			else
				@operators[sas_op.name] = sas_op
			end
		end

=begin
		def substitute_goal_value_in_effects(procedure)
			effects = procedure['_effect']
			effects.each_key do |key|
				effects[key]
			end
		end
=end

		# process all object procedures in order to get
		# grounded SAS-operator
		def process_procedure(procedure, object)
			#substitute_goal_value_in_effects(procedure)

			operators = ground_procedure_parameters(procedure)
			if operators != nil
				operators.each { |op| process_operator(op) }
			end
			# remove the procedure because we don't need it anymore
			object.delete(procedure['_self'])
		end

		# determine all possible sets of parameters' value
		# and create an operator for each set
		def ground_procedure_parameters(procedure)
			params = Hash.new
			procedure.each { |k,v|
				next if k[0,1] == '_'
### debug
#puts procedure.ref
#p = Sfp::Helper.deep_clone(procedure)
#p.accept(Sfp::Visitor::ParentEliminator.new)
#p.delete('_parent')
#puts JSON.pretty_generate(p)
### end debug
				type = case v
				when Sfp::Undefined
					v.type
				when Hash
					case v['_context']
					when 'null', 'any_value'
						v['_isa']
					when 'set'
						"(#{v['_isa']})"
					else
						nil
					end
				else
					return nil
				end

				#if not @types.has_key?( v['_isa'] )
				#	return nil
				#end
				#type = case v['_context']
				#	when 'null', 'any_value'
				#		v['_isa']
				#	when 'set'
				#		"(#{v['_isa']})"
				#	else
				#		nil
				#	end

				#next if type == nil
				#raise TypeNotFoundException, type if not @types.has_key?(type)

				# if the specified parameter does not have any value,
				# then it's invalid procedure (should print a warning)
				return nil if not @types.has_key?(type)

				params[k] = Array.new
				@types[ type ].each { |val| params[k] << val if
					not (val.is_a?(Hash) and val.isnull) and
					!val.is_a?(Sfp::Undefined) and !val.is_a?(Sfp::Unknown) }
			}
			# combinatorial method for all possible values of parameters
			# using recursive method
			def combinator(bucket, grounder, procedure, names, params, selected, index)
				if index >= names.length
					p = Sfp::Helper.deep_clone(procedure) # procedure.clone
					# grounding all references
					selected['$.this'] = procedure['_parent'].ref
					selected.each { |k,v| selected[k] = (v.is_a?(Hash) ? v.ref : v) }
					grounder.map = selected
					p['_condition'].accept(grounder)
					p['_effect'].accept(grounder)
					p['_context'] = 'operator'
					p['_parameters'] = selected.clone
					# remove parameters because it's already grounded
					p.each { |k,v| p.delete(k) if k[0,1] != '_' }
					bucket << p
				else
					params[ names[index] ].each { |val|
						ref = '$.' + names[index]
						selected[ref] = val
						combinator(bucket, grounder, procedure, names, params, selected, index+1)
						selected.delete(ref)
					}
				end
			end
			bucket = Array.new
			grounder = ParameterGrounder.new(@root['initial'])
			combinator(bucket, grounder, procedure, params.keys, params, Hash.new, 0)
			return bucket
		end

		def dump_types
			puts '--- types'
			@types.each { |name,values|
				next if values == nil
				print name + ": "
				values.each { |val|
					if val.is_a?(Hash)
						print (val.isnull ? 'null ' : val.ref + " ")
					else
						print val.to_s + " "
					end
				}
				puts '| ' + values.length.to_s
			}
		end

		def dump_vars
			puts '--- variables'
			@variables.each_value { |value| puts value.to_s }
		end

		def dump_operators
			puts '--- operators'
			@operators.each_value { |op| puts op.to_s + ' -- ' + op.params.inspect }
		end

		def dump_axioms
			puts '--- axioms'
			@axioms.each { |ax| puts ax.to_s }
		end

		# set possible values for each variable
		def set_variable_values
			@variables.each_value { |var|
				var.clear
				if not var.is_final
					@types[var.type].each { |v| var << v }
				else
					var << var.init
				end
			}
		end

		def add_unknown_value_to_nonstatic_variables
			@variables.each_value { |variable|
				next if variable.is_final
				variable << @unknown_value
			}
		end

		def add_unknown_undefined_value_to_variables
			@variables.each_value { |variable|
				#next if variable.is_final
				variable << @unknown_value
				variable << Sfp::Undefined.create(variable.type)
				variable.uniq!
			}
		end

		def apply_global_constraint_method_1(operator)
			return true if not @root.has_key?('global') or not @root['global'].isconstraint
			operator[@global_var.name] = Parameter.new(@global_var, true, false)
		end

		# return true if global constraint could be applied, otherwise false
		def apply_global_constraint_method_2(operator)
			return true if not @root.has_key?('global') or #@root['global'] == nil or
				not @root['global'].isconstraint

			# return true if operator's effect is consistent with "left := right"
			def consistent_with_equals(left, right, operator)
				return false if operator.has_key?(left) and operator[left].post != nil and
					operator[left].post != right['_value']
				return true
			end

			# return true if operator's effect is consistent with given 'and' constraint
			def consistent_with_and(constraint, operator)
				constraint.each { |k,v|
					next if k[0,1] == '_'
					return false if not consistent_with_equals(k, v, operator)
				}
				return true
			end

			# global constraint is AND formula
			return consistent_with_and(@root['global'], operator) if
					@root['global']['_type'] == 'and'
			
			# global constraint is OR formula
			total = 0
			satisfied = Array.new
			@root['global'].each { |k,v|
				next if k[0,1] == '_'
				total += 1
				satisfied << k if consistent_with_and(v, operator)
			}
			if satisfied.length < total
				# partial satisfaction or OR formula
				satisfied.each { |key|
					# create an operator for each satisfied sub-formula
					op = operator.clone
					op.modifier_id = key
					map_cond = and_equals_constraint_to_map(@root['global'][key])
					map_cond.each { |k,v|
						next if k[0,1] == '_'
						raise VariableNotFoundException, 'Variable not found: ' + k if
							not @variables.has_key?(k)
						if not op.has_key?(@variables[k].name)
							op[@variables[k].name] = Parameter.new(@variables[k], v, nil)
						else
							#op[@variables[k].name].pre = v
						end
					}
					@operators[op.name] = op
					@g_operators << op
				}
				# the original operator is not required
				return false
			end

			return true
		end

		# normalize the given first-order formula by transforming it to DNF
		#
		def normalize_formula(formula, dump=false)
			{:formula => formula}.accept(ImplicationToDisjunction)

			def create_equals_constraint(value)
				return {'_context'=>'constraint', '_type'=>'equals', '_value'=>value}
			end

			def create_not_equals_constraint(value)
				return {'_context'=>'constraint', '_type'=>'not-equals', '_value'=>value}
			end

			def create_not_constraint(key, parent)
				return {'_context'=>'constraint', '_type'=>'not', '_self'=>key, '_parent'=>parent}
			end

			def create_and_constraint(key, parent)
				return {'_context'=>'constraint', '_type'=>'and', '_self'=>key, '_parent'=>parent}
			end

			def create_or_constraint(key, parent)
				return {'_context'=>'constraint', '_type'=>'or', '_self'=>key, '_parent'=>parent}
			end

			def array_to_or_constraint(arr)
				c = {'_context'=>'constraint', '_type'=>'or'}
				arr.each { |v| c[Sfp::SasTranslator.next_constraint_key] = v }
				return c
			end

			# combinatorial method for all possible values of nested reference
			# using recursive method
			def ref_combinator(bucket, parent, names, last_value, last_names=nil,
					index=0, selected=Hash.new)

				return if names[index] == nil
				var_name = parent + '.' + names[index]
				if not @variables.has_key?(var_name)
					raise VariableNotFoundException, 'Variable not found: ' + var_name
				end

				if index >= names.length or (index >= names.length-1 and last_value != nil)
					selected[var_name] = last_value if last_value != nil
					last_names << var_name if last_names != nil
					result = selected.clone
					result['_context'] = 'constraint'
					result['_type'] = 'and'
					bucket << result
				else
					@variables[var_name].each { |v|
						next if v.is_a?(Hash) and v.isnull
						v = v.ref if v.is_a?(Hash) and v.isobject
						selected[var_name] = create_equals_constraint(v)
						ref_combinator(bucket, v, names, last_value, last_names, index+1, selected)
					}
				end
				selected.delete(var_name)
			end

			def break_nested_reference(ref)
				rest, last = ref.pop_ref
				names = [last]
				while rest != '$' and not @variables.has_key?(rest)
					rest, last = rest.pop_ref
					names.unshift(last)
				end
				rest, last = rest.pop_ref
				names.unshift(last)
				return [names, rest]
			end

			def normalize_nested_right_only_multiple_values(left, right, formula)
				# TODO -- evaluate this method
				ref = right['_value']
				key1 = Sfp::SasTranslator.next_constraint_key
				c_or = create_or_constraint(key1, formula)
				@variables[ref].each do |v|
					value = ( (v.is_a?(Hash) and v.isobject) ? v.ref : v)
					key2 = Sfp::SasTranslator.next_constraint_key
					c_and = create_and_constraint(key2, c_or)
					#c_and[ref] = create_equals_constraint(value) ## HACK! -- this should be uncomment
					c_and[left] = create_equals_constraint(value) if right['_type'] == 'equals'
					c_and[left] = create_not_equals_constraint(value) if right['_type'] == 'not-equals'
					c_or[key2] = c_and
				end
				formula.delete(left)
				formula[key1] = c_or
				return key1
			end

			def normalize_nested_right_values(left, right, formula)
				# TODO
				#puts 'nested right: ' + left + ' = ' + right['_value']

				raise TranslationException, "not implemented: normalized_nested_right => #{right}"
			end

			def normalize_nested_right_only(left, right, formula)
				value = right['_value']
				return if @variables.has_key?(value) and @variables[value].is_final

				if @variables.has_key?(value)
					normalize_nested_right_only_multiple_values(left, right, formula)
				else
					normalize_nested_right_values(left, right, formula)
				end
			end

			def normalize_nested_left_right(left, right, formula)
				# TODO
				#puts 'nested left-right'
				#names, rest = break_nested_reference(left)
				#bucket1 = Array.new
				#last_names1 = Array.new
				#ref_combinator(bucket1, rest, names, nil, last_names1)

				raise TranslationException, 'not implemented: normalized_nested_left_right'
			end

			def normalize_nested_left_only(left, right, formula)
				names, rest = break_nested_reference(left)
				bucket = Array.new
				ref_combinator(bucket, rest, names, right)
				formula.delete(left)
				if bucket.length > 0
					key = Sfp::SasTranslator.next_constraint_key
					formula[key] = array_to_or_constraint(bucket)
					to_and_or_graph(formula[key])
					return key
				end
			end

			# transform a first-order formula into AND/OR graph
			def to_and_or_graph(formula)
				keys = formula.keys
				keys.each { |k|
					next if k[0,1] == '_'
					v = formula[k]
					if k.isref and not @variables.has_key?(k)
						if v.is_a?(Hash) and v.isconstraint
							if (v['_type'] == 'equals' or v['_type'] == 'not-equals') and
									v['_value'].is_a?(String) and v['_value'].isref and
									not @variables.has_key?(v['_value'])
								# nested left & right
								normalize_nested_left_right(k, v, formula)
							elsif (v['_type'] == 'or' or v['_type'] == 'and')
								to_and_or_graph(v)
							else
								# nested left only
								normalize_nested_left_only(k, v, formula)
							end
						end
					else
						if v.is_a?(Hash) and v.isconstraint
							if (v['_type'] == 'equals' or v['_type'] == 'not-equals') and
									v['_value'].is_a?(String) and v['_value'].isref 
								# nested right only
								normalize_nested_right_only(k, v, formula)
							elsif (v['_type'] == 'or' or v['_type'] == 'and')
								to_and_or_graph(v)
							end
						end
					end
				}
			end


			# Recursively pull statements that has the same AND/OR operator.
			# Only receive a formula with AND, OR, EQUALS constraints.
			#
			# return false if there is any contradiction of facts, otherwise true
			def flatten_and_or_graph(formula)
				# transform formula into a format:
				#   (x1 and x2) or (y1 and y2 and y3) or z1
				is_and_or_tree = false
				formula.keys.each { |k|
					next if k[0,1] == '_'
					v = formula[k]
					if v.is_a?(Hash) and v.isconstraint
						if v['_type'] == 'or' or v['_type'] == 'and'
							if not flatten_and_or_graph(v)
								# remove it because it's not consistent
								formula.delete(k)
								v['_parent'] = nil
							end

							if formula['_type'] == v['_type']
								# pull-out all node's elements
								v.keys.each { |k1|
									next if k1[0,1] == '_'
									v1 = v[k1]
									# check contradiction facts
									if formula.has_key?(k1)
										return false if formula[k1]['_type'] != v1['_type']
										return false if formula[k1]['_value'] != v1['_value']
									else
										formula[k1] = v1
									end
								}
								formula.delete(k)
							end
							is_and_or_tree = true if formula['_type'] == 'and' and v['_type'] == 'or'
						end
					end
				}
				# dot-product the nodes
				def cross_product_and(bucket, names, formula, values=Hash.new, index=0)
					if index >= names.length
						key = Sfp::SasTranslator.next_constraint_key
						c = create_and_constraint(key, formula)
						values.each { |k,v| c[k] = v }
						if flatten_and_or_graph(c)
							# add the constraint because it's consistent
							formula[key] = c
						end
					else
						key = names[index]
						val = formula[ key ]
						if val.is_a?(Hash) and val.isconstraint and val['_type'] == 'or'
							val.each { |k,v|
								next if k[0,1] == '_'
								values[k] = v
								cross_product_and(bucket, names, formula, values, index+1)
								values.delete(k)
							}
						else
							values[key] = val
							cross_product_and(bucket, names, formula, values, index+1)
						end
					end
				end
				if is_and_or_tree
					# change it into OR->AND tree
					names = Array.new
					formula.keys.each { |k| names << k if k[0,1] != '_' }
					bucket = Array.new
					cross_product_and(bucket, names, formula)
					names.each { |k| formula.delete(k) }
					formula['_type'] = 'or'
				end

				return true
			end

			# 'var_name' := x, value := p1
			# variable x := p1 | p2 | p3
			# return an array (p2, p3)
			def get_list_not_value_of(var_name, value)
				raise VariableNotFoundException, 'Variable not found: ' + var_name if
					not @variables.has_key?(var_name)
				if value.is_a?(String) and value.isref
					value = @root['initial'].at?(value)
				elsif value.is_a?(Hash) and value.isnull
					value = @variables[var_name][0]
				end
				return (@variables[var_name] - [value])
			end

			# variable x := p1 | p2 | p3
			# then formula  (x not-equals p1) is transformed into
			# formula ( (x equals p2) or (x equals p3) )
			def not_equals_statement_to_or_constraint(formula)
				formula.keys.each do |k|
					next if k[0,1] == '_'
					v = formula[k]
					if v.is_a?(Hash) and v.isconstraint
						if v['_type'] == 'or' or v['_type'] == 'and'
							not_equals_statement_to_or_constraint(v)
						elsif v['_type'] == 'not-equals'
							key1 = Sfp::SasTranslator.next_constraint_key
							c_or = create_or_constraint(key1, formula)
							get_list_not_value_of(k, v['_value']).each do |val1|
								val1 = val1.ref if val1.is_a?(Hash) and val1.isobject
								key2 = Sfp::SasTranslator.next_constraint_key
								c_and = create_and_constraint(key2, c_or)
								c_and[k] = create_equals_constraint(val1)
								c_or[key2] = c_and
							end
							formula.delete(k)
							formula[key1] = c_or
						end
					end
				end
			end

			def substitute_template(grounder, template, parent)
				id = Sfp::SasTranslator.next_constraint_key
				c_and = Sfp::Helper.deep_clone(template)
				c_and['_self'] = id
				c_and.accept(grounder)
				parent[id] = c_and
				remove_not_and_iterator_constraint(c_and)
				c_and
			end

			# Remove the following type of constraint in the given formula:
			# - NOT constraints by transforming them into EQUALS, NOT-EQUALS, AND, OR constraints
			# - ARRAY-Iterator constraint by extracting all possible values of given ARRAY
			#
			def remove_not_and_iterator_constraint(formula)
				# (not (equals) (not-equals) (and) (or))
				if formula.isconstraint and formula['_type'] == 'not'
					formula['_type'] = 'and'
					formula.each { |k,v|
						next if k[0,1] == '_'
						if v.is_a?(Hash) and v.isconstraint
							case v['_type']
							when 'equals'
								v['_type'] = 'not-equals'
							when 'not-equals'
								v['_type'] = 'equals'
							when 'and'
								v['_type'] = 'or'
								v.keys.each { |k1|
									next if k1[0,1] == '_'
									v1 = v[k1]
									k2 = Sfp::SasTranslator.next_constraint_key
									c_not = create_not_constraint(k2, v)
									c_not[k1] = v1
									v1['_parent'] = c_not
									v.delete(k1)
									remove_not_and_iterator_constraint(c_not)
								}
							when 'or'
								v['_type'] = 'and'
								v.keys.each { |k1|
									next if k1[0,1] == '_'
									v1 = v[k1]
									k2 = Sfp::SasTranslator.next_constraint_key
									c_not = create_not_constraint(k2, v)
									c_not[k1] = v1
									v1['_parent'] = c_not
									v.delete(k1)
									remove_not_and_iterator_constraint(c_not)
								}
							else
								raise TranslationException, 'unknown rules: ' + v['_type']
							end
						end
					}
				elsif formula.isconstraint and formula['_type'] == 'iterator'
					ref = formula['_value']
					var = '$.' + formula['_variable']
					if @arrays.has_key?(ref)
						# substitute ARRAY
						total = @arrays[ref]
						grounder = ParameterGrounder.new(@root['initial'], {})
						for i in 0..(total-1)
							grounder.map.clear
							grounder.map[var] = ref + "[#{i}]"
							substitute_template(grounder, formula['_template'], formula)
						end
					else
						setvalue = (ref.is_a?(Array) ? ref : @root['initial'].at?(ref))
						if setvalue.is_a?(Hash) and setvalue.isset
							# substitute SET
							grounder = ParameterGrounder.new(@root['initial'], {})
							setvalue['_values'].each do |v|
								grounder.map.clear
								grounder.map[var] = v
								substitute_template(grounder, formula['_template'], formula)
							end
						elsif setvalue.is_a?(Array)
							grounder = ParameterGrounder.new(@root['initial'], {})
							setvalue.each do |v|
								grounder.map.clear
								grounder.map[var] = v
								substitute_template(grounder, formula['_template'], formula)
							end
						else
							#puts setvalue.inspect + ' -- ' + formula.ref + ' -- ' + var.to_s
							#raise UndefinedValueException, 'Undefined'
							raise UndefinedValueException.new(var)
						end
					end
					formula['_type'] = 'and'
					formula.delete('_value')
					formula.delete('_variable')
					formula.delete('_template')
				elsif formula.isconstraint and formula['_type'] == 'forall'
					classref = '$.' + formula['_class']
					raise TypeNotFoundException, classref if not @types.has_key?(classref)
					var = '$.' + formula['_variable']
					grounder = ParameterGrounder.new(@root['initial'], {})
					@types[classref].each do |v|
						next if v == nil or (v.is_a?(Hash) and v.isnull)
						grounder.map.clear
						grounder.map[var] = v.ref
						substitute_template(grounder, formula['_template'], formula)
					end
					formula['_type'] = 'and'
					formula.delete('_class')
					formula.delete('_variable')
					formula.delete('_template')
				else
					formula.each { |k,v|
						next if k[0,1] == '_'
						remove_not_and_iterator_constraint(v) if v.is_a?(Hash) and v.isconstraint
					}
				end
			end

			### testing/debugging methods
			def calculate_depth(formula, depth)
				formula.each { |k,v|
					next if k[0,1] == '_'
					depth = calculate_depth(v, depth+1)
					break
				}
				depth
			end

			def total_element(formula, total=0, total_or=0, total_and=0)
				formula.each { |k,v|
					next if k[0,1] == '_'
					if v['_type'] == 'or'
						total_or += 1
					elsif v['_type'] == 'and'
						total_and += 1
					else
					end
					total, total_or, total_and = total_element(v, total+1, total_or, total_and)
				}
				[total,total_or,total_and]
			end

			def visit_and_or_graph(formula, map={}, total=0)
				if formula['_type'] == 'and'
					map = map.clone
					is_end = true
					formula.each do |k,v|
						next if k[0,1] == '_'
						if v['_type'] == 'equals'
							# bad branch
							if map.has_key?(k) and map[k] != v['_value']
								return
							end
							map[k] = v['_value']
						elsif v['_type'] == 'and' or v['_type'] == 'or'
							is_end = false
						end
					end

					if is_end
						# map is valid conjunction
					else
						formula.each do |k,v|
							next if k[0,1] == '_'
							if v['_type'] == 'and' or v['_type'] == 'or'
								return visit_and_or_graph(v, map, total)
							end
						end
					end

				elsif formula['_type'] == 'or'
					formula.each do |k,v|
						next if k[0,1] == '_'
						if v['_type'] == 'equals'
							# bad branch
							if map.has_key?(k) and map[k] != v['_value']
							end
							final_map = map.clone
							final_map[k] = v['_value']
							# map is valid conjunction
						elsif v['_type'] == 'and' or v['_type'] == 'or'
							visit_and_or_graph(v, map, total)
						end
					end

				end
				total
			end
			### end of testing/debugging methods

			remove_not_and_iterator_constraint(formula)
			to_and_or_graph(formula)
			not_equals_statement_to_or_constraint(formula)

			return flatten_and_or_graph(formula)
		end


		def self.null_of(class_ref=nil)
			return { '_context' => 'null', '_isa' => class_ref } if class_ref.is_a?(String) and
				class_ref != '' and class_ref.isref
			return nil
		end


		ImplicationToDisjunction = Object.new
		def ImplicationToDisjunction.visit(name, value, parent)
			return if !value.is_a?(Hash)
			if value['_type'] == 'imply'
				value['_type'] = 'or'
				value.each_value { |f| f['_type'] = 'not' if f['_subtype'] == 'premise' }
			end
			true
		end

		### Helper Classes ###

		class VariableNotFoundException < Exception; end
	
		class TypeNotFoundException < Exception;	end
	
		class UndefinedValueException < Exception
			attr_accessor :var
	
			def to_s; return @var; end
		end

		# Visitor class has 3 attributes
		# - root : Hash instance of root Context
		# - variables: Hash instance that holds all Variable instances
		# - types: Hash instance that holds all types (primitive or non-primitive)
		class Visitor
			def initialize(main)
				@main = main
				@root = main.root
				@vars = main.variables
				@types = main.types
			end
		end
	
		# Visitor that set goal value of each variable
		class GoalVisitor < Visitor
			def set_equals(name, value)
				value = @types[@vars[name].type][0] if value.is_a?(Hash) and value.isnull
				value = @root['initial'].at?(value) if value.is_a?(String) and value.isref
				@vars[name].goal = value
			end
	
			def visit(name, value, obj)
				return if name[0,1] == '_'
				raise VariableNotFoundException, 'Variable not found: ' + name if
					not @vars.has_key?(name)
				if value.isconstraint
					self.set_equals(name, value['_value']) if value['_type'] == 'equals'
				end
				return true
			end
		end
	
		# collecting all variables and put them into @bucket
		class VariableCollector < Visitor
			def initialize(main)
				super(main)
				@init = main.root['initial']
			end
	
			def visit(name, value, parent)
				return false if name[0,1] == '_'
				return false if (value.is_a?(Hash) and not (value.isobject or value.isnull or value.isset))
									# or value.is_a?(Array)
	
				var_name = parent.ref.push(name)
				isfinal = self.is_final(value)
				isref = (value.is_a?(String) and value.isref)
				isset = false
				value = @init.at?(value) if isref
				type = (isfinal ? self.isa?(value) : self.get_type(name, value, parent))
				if type == nil
					raise Exception, "Unrecognized type of variable: #{var_name}:#{value.class}"
				else
					value = null_value(type) if value == nil
					isset = true if type[0,1] == '('
					var = Variable.new(var_name, type, -1, value, nil, isfinal)
					var.isset = isset
					@vars[var.name] = var
					if isfinal and value.is_a?(Hash)
						value['_classes'].each { |c| add_value(c, value) }
					elsif not isref
						add_value(type, value)
					end
				end
				return true
			end
	
			def null_value(isa)
				return {'_context' => 'null', '_isa' => isa}
			end
	
			def get_type(name, value, parent)
				return value.type if value.is_a?(Sfp::Undefined) or value.is_a?(Sfp::Unknown)

				type = nil
				if parent.has_key?('_isa')
					isa = @main.root.at?(parent['_isa'])
					if not isa.nil?
						type = isa.type?(name)
						return type if not type.nil?
					end
				end
				type = self.isa?(value)

				return "(#{value['_isa']})" if value.is_a?(Hash) and value.isset and value.has_key?('_isa')
	
				return nil if type == nil
	
				return type if type.is_a?(String) and type.isref
	
				parent_class = @root.at?( @vars[parent.ref].type )
				return parent_class[name]['_isa']
			end
	
			def add_value(type, value)
				if not @types.has_key?(type)
					@types[type] = Array.new
					@types[type] << Sfp::SasTranslator.null_of(type) if @types[type].length <= 0
				end
				@types[type] << value if not (value.is_a?(Hash) and value.isnull)
			end
	
			def isa?(value)
				return '$.Boolean' if value.is_a?(TrueClass) or value.is_a?(FalseClass)
				return '$.Integer' if value.is_a?(Numeric)
				return '$.String' if value.is_a?(String) and not value.isref
				return value['_isa'] if value.is_a?(Hash) and value.isobject
				return nil
			end
	
			def is_final(value)
				return true if value.is_a?(Hash) and not value.isnull and not value.isset
				return false
			end
		end
	
		# Collects all values (primitive or non-primitive)
		class ValueCollector
			def initialize(sas)
				@bucket = sas.types
				@sas = sas
			end
	
			def visit(name, value, obj)
				return true if name[0,1] == '_' and name != '_value'
				type = get_type(value)
				if type != nil
					@bucket[type] << value
				elsif value.is_a?(Hash)
					if value.isobject
						value['_classes'].each { |c| @bucket[c] << value }
					elsif value.isset
						raise TranslationException, 'not implemented -- set: ' + value['_isa']
					end
				elsif value.is_a?(Array)
					if value.length > 0
						type = get_type(value[0])
						if type != nil
							type = "(#{type})" # an array
							#raise Exception, "type not found: #{type}" if not @bucket.has_key?(type)
							@bucket[type] = [] if not @bucket.has_key?(type)
							@bucket["#{type}"] << value
						elsif value[0].is_a?(String) and value[0].isref
							val = @sas.root['initial'].at?(value[0])
							return true if val == nil
							type = get_type(val)
							if type != nil
								@bucket["(#{type})"] << value
							elsif val.is_a?(Hash) and val.isobject
								val['_classes'].each { |c| @bucket["(#{c})"] << value if @bucket.has_key?("(#{c})") }
							end
						end
					end
				else
				end
				return true
			end
	
			def get_type(value)
				if value.is_a?(String) and not value.isref
					'$.String'
				elsif value.is_a?(Numeric)
					'$.Integer'
				elsif value.is_a?(TrueClass) or value.is_a?(FalseClass)
					'$.Boolean'
				else
					nil
				end
			end
		end
	
		class ParameterGrounder
			attr_accessor :map
	
			def initialize(root, map={})
				@root = root
				@map = map
			end
	
			def visit(name, value, obj)
				return if name[0,1] == '_' and name != '_value' and name != '_template'
				# substituting left side
				if name[0,1] != '_'
					modified = false
					map.each { |k,v|
						#puts k + ',' + name if v.is_a?(Sfp::Undefined) or v.is_a?(Sfp::Unknown)
						next if v.is_a?(Sfp::Undefined) or v.is_a?(Sfp::Unknown)
						if name == k
							obj[v] = value
							obj.delete(name)
							name = v
							value['_self'] = name if value.is_a?(Hash)
							modified = true
							break
						elsif name.length > k.length and name[k.length,1] == '.' and name[0, k.length] == k
							#next if v.is_a?(Sfp::Undefined) or v.is_a?(Sfp::Unknown)
							grounded = v + name[k.length, (name.length-k.length)]
							obj[grounded] = value
							obj.delete(name)
							name = grounded
							value['_self'] = name if value.is_a?(Hash)
							modified = true
							break
						end
					}
	
					if modified and (name =~ /.*\.parent(\..*)?/ )
						parent, last = name.pop_ref
						parent_value = @root.at?(parent)
						raise VariableNotFoundException, parent if parent_value.nil?
						new_name = @root.at?(parent).ref.push(last) if last != 'parent'
						new_name = @root.at?(parent).ref.to_top if last == 'parent'
						obj[new_name] = value
						obj.delete(name)
						name = new_name
						value['_self'] = name if value.is_a?(Hash)
					end
				end
				# TODO ----- HACK! -----
				if obj.is_a?(Hash) and obj.isconstraint and obj['_type'] == 'iterator' and
						value.is_a?(String) and value.isref and map.has_key?(value)
					obj[name] = value = map[value]
					#puts map[value].inspect
					#puts "==>> " + obj.ref.push(name)
				end
				# ------ END of HACK! ----

				# substituting right side
				if value.is_a?(String) and value.isref
					map.each { |k,v|
						if value == k
							obj[name] = v
							break
						elsif value.length > k.length and value[k.length,1] == '.' and value[0,k.length] == k and
						  not(v.is_a?(Sfp::Undefined) or v.is_a?(Sfp::Unknown))
							obj[name] = v + value[k.length, (value.length-k.length)]
							break
						end
					}
				end
				return true
			end
		end
	end


	# SAS Variable is a finite-domain variable
	# It has a finite set of possible values
	class Variable < Array
		# @name -- name of variable
		# @type -- type of variable ('string','boolean','number', or fullpath of a class)
		# @layer -- axiom layer ( '-1' if this is not axiom variable, otherwise >0)
		# @init -- initial value
		# @goal -- goal value (desired value)
		attr_accessor :name, :type, :layer, :init, :goal, :is_final, :id, :mutable, :isset
		attr_reader :is_primitive

		def initialize(name, type, layer=-1, init=nil, goal=nil, is_final=false)
			@name = name
			@type = type
			@layer = layer
			@init = init
			@goal = goal
			@is_final = is_final
			@is_primitive = (type == '$.String' or type == '$.Integer' or type == '$.Boolean')
			@mutable = true
		end

		def to_s
			s = @name.to_s + '|' + @type.to_s
			s << '|'
			s << (@init == nil ? '-' : (@init.is_a?(Hash) ? @init.tostring : @init.to_s))
			s << '|'
			s << (@goal == nil ? '-' : (@goal.is_a?(Hash) ? @goal.tostring : @goal.to_s))
			s << '|'
			s << (@is_final ? 'final' : 'notfinal') + "\n"
			s << "\t["
			self.each { |v| s << (v.is_a?(Hash) ? v.tostring : v.to_s) + ',' }
			s = (self.length > 0 ? s.chop : s)
			s << "]"
		end

		# return variable representation in SAS+ format
		def to_sas(root)
			sas = "begin_variable\nvar_#{@id}#{@name}\n#{@layer}\n#{self.length}\n"
			self.each { |v|
				if v.is_a?(String) and v.isref
					v = root.at?(v)
				end
				v = '"' + v + '"' if v.is_a?(String)
				sas << (v.is_a?(Hash) ? (v.isnull ? "null\n" : "#{v.ref}\n") : "#{v}\n")
			}
			sas << "end_variable\n"
		end

		def dump(stream, root)
			stream.write "begin_variable\nvar_#{@id}#{@name}\n#{@layer}\n#{self.length}\n"
			self.each { |v|
				v = root.at?(v) if v.is_a?(String) and v.isref
				v = '"' + v + '"' if v.is_a?(String)
				stream.write (v.is_a?(Hash) ? (v.isnull ? "null\n" : "#{v.ref}\n") : "#{v}\n")
			}
			stream.write "end_variable\n"
		end

		def not(x)
			self.select { |y| y != x }
		end
	end

	# A class for Grounded Operator
	class Operator < Hash
		attr_accessor :id, :name, :cost, :params, :modifier_id
		attr_reader :ref

		def initialize(ref, cost=1, id=nil)
			@id = (id == nil ? Sfp::SasTranslator.next_operator_id : id)
			@cost = cost
			@ref = ref
			@modifier_id = nil
			self.update_name
		end

		def clone
			op = Operator.new(@ref, @cost)
			op.params = @params
			self.each { |key,param| op[key] = param.clone }
			return op
		end

		def update_name
			@name = 'op_' + @id.to_s + @ref
		end

		# return true if this operator supports given operator's precondition
		# otherwise return false
		def supports?(operator)
			operator.each_value do |p2|
				# precondition is any value or this operator does not effecting variable 'p2'
				next if p2.pre == nil or not self.has_key?(p2.var.name) or
						self[p2.var.name].post == nil
				return true if self[p2.var.name].post == p2.pre
			end
			false
		end

		# return true if this operator requires an effect of given operator
		# otherwise return false
		def requires?(operator)
			self.each_value do |p1|
				next if p1.pre == nil # can be any value
				p2 = operator[p1.var.name]
				if p2 != nil and p2.post != nil and p1.pre == p2.post and p2.pre == nil
					return true
				end
			end
			return false
		end

		def merge(operator)
			cost = (@cost > operator.cost ? @cost : operator.cost)
			names = @name.split('#')
			name = (names.length > 1 ? names[1] : names[0])
			op = Operator.new('#' + name + '|' + operator.name, cost)
			self.each_value { |p| op[p.var.name] = p.clone }
			operator.each_value do |p|
				if not op.has_key?(p.var.name)
					op[p.var.name] = p.clone
				elsif p.post != nil
					op[p.var.name] = p.clone
				end
			end
			return op
		end

		def total_prevails
			count = 0
			self.each_value { |p| count += 1 if p.post.nil? }
			count
		end

		def total_preposts
			count = 0
			self.each_value { |p| count += 1 if not p.post.nil? }
			count
		end

		def get_pre_state
			state = {}
			self.each_value { |p| state[p.var.name] = p.pre if p.pre != nil }
			state
		end

		def get_post_state
			state = {}
			self.each_value { |p| state[p.var.name] = p.post if p.post != nil }
			state
		end

		# two operators can be parallel if
		# - their preconditions are non consistent
		# - their effects are not consistent
		# - one's during condition is not consistent with another
		def conflict?(operator)
			self.each_value do |param1|
				next if not operator.has_key?(param1.var.name)
				param2 = operator[param1.var.name]
				return true if param1.pre != nil and param2.pre != nil and param1.pre != param2.pre
				return true if param1.post != nil and param2.post != nil and param1.post != param2.post
				return true if param1.pre != nil and param2.post != nil and param1.pre != param2.post
				return true if param1.post != nil and param2.pre != nil and param1.post != param2.pre
			end
			return false
		end

		def to_s
			#return @name + ': ' + self.length.to_s
			return @name + ": " + (self.map { |k,v| v.to_s }).join("|")
		end

		def to_sas(root, variables)
			prevails = self.values.select { |p| p.post.nil? }
			preposts = self.values.select { |p| not p.post.nil? }

			sas = "begin_operator\n#{@name}"
			@params.each do |key,val|
				sas << " #{key}=#{val}" if key != '$.this'
			end if @params.is_a?(Hash)

			sas << "\n#{prevails.length}\n"
			prevails.each do |p|
				line = p.to_sas(root, variables)
				#raise TranslationException if line[-1] == ' '
				return nil if line[-1] == ' '
				sas << "#{line}\n"
			end

			sas << "#{preposts.length}\n"
			preposts.each do |p|
				line = p.to_sas(root, variables, false)
				#raise TranslationException if line[-1] == ' '
				return nil if line[-1] == ' '
				sas << "#{line}\n"
			end

			sas << "#{@cost}\nend_operator\n"
		end

		def dump(stream, root, variables)
			prevails = self.values.select { |p| p.post.nil? }
			preposts = self.values.select { |p| not p.post.nil? }
=begin
			pre_lines = []
			prevails.each do |p|
				line = p.to_sas(root, variables)
				return if line[-1] == ' '
				pre_lines << line
			end
			prepost_lines = []
			preposts.each do |p|
				line = p.to_sas(root, variables, false)
				return if line [-1] == ' '
				prepost_lines << line
			end
=end

			stream.write "begin_operator\n#{@name}"
			@params.each do |key,val|
				stream.write " #{key}=#{val}" if key != '$.this'
			end if @params.is_a?(Hash)

=begin
			stream.write "\n#{pre_lines.length}"
			stream.write "\n#{pre_lines.join("\n")}" if pre_lines.length > 0
			stream.write "\n#{prepost_lines.length}\n"
			stream.write "#{prepost_lines.join("\n")}\n" if prepost_lines.length > 0
=end
			stream.write "\n#{prevails.length}\n"
			prevails.each { |p| p.dump(stream, root, variables) }

			stream.write "#{preposts.length}\n"
			preposts.each { |p| p.dump(stream, root, variables, false) }

			stream.write "#{@cost}\nend_operator\n"
		end

		def to_sfw
			if not (@name =~ /.*\$.*/)
				id , name = @name.split('-', 2)
			else
				id, name = @name.split('$', 2)
			end

			sfw = { 'name' => '$' + name,
			        'parameters' => {},
			        'condition' => {},
			        'effect' => {} }

			@params.each { |k,v|
				sfw['parameters'][k.to_s] = v if k != '$.this'
			} if @params != nil

			self.each_value do |param|
				next if param.var.name == Sfp::SasTranslator::GlobalVariable
				p = param.to_sfw
				if not p['pre'].nil?
					sfw['condition'][p['name']] = (p['pre'].is_a?(Sfp::Null) ? nil : p['pre'])
				end
				if not p['post'].nil?
					sfw['effect'][p['name']] = (p['post'].is_a?(Sfp::Null) ? nil : p['post'])
				end

				#sfw['condition'][ p['name'] ] = p['pre'] if p['pre'] != nil
				#sfw['effect'][ p['name'] ] = p['post'] if p['post'] != nil
			end
			return sfw
		end
	end

	# A class for Grounded Axiom
	class Axiom < Hash
		attr_accessor :id, :target

		def initialize
			@id = Sfp::SasTranslator.next_axiom_id
		end

		def to_s
			return 'axiom#' + @id.to_s
		end

		def to_sas(root, variables)
			prevails = select { |var,param| param.post.nil? }
			preposts = select { |var,param| !param.post.nil? }
			raise Exception, "Invalid axiom: total preposts > 1" if preposts.length > 1
			raise Exception, "Invalid axiom: total preposts <= 0" if preposts.length <= 0

			sas = "begin_rule"
			sas << "\n#{prevails.length}"
			prevails.each { |var,param| sas << "\n#{param.to_sas(root, variables)}" }
			preposts.each { |var,param| sas << "\n#{param.to_sas(root, variables)}" }
			sas << "\nend_rule"
			return sas
		end
	end

	# A class for operator/axiom parameter (prevail or effect condition)
	# :pre = nil - it can be anything (translated to -1)
	# :post = nil - variable's value doesn't change
	class Parameter
		attr_accessor :var, :pre, :post

		def initialize(var, pre, post=nil)
			@var = var
			@pre = pre
			@post = post
		end

		def prevail?
			return (@post == nil)
		end

		def effect?
			return (@post != nil)
		end

		def clone
			return Parameter.new(@var, @pre, @post)
		end

		def to_sas(root, variables, is_prevail=true)
			### resolve reference
			pre = ((@pre.is_a?(String) and @pre.isref) ? variables[@pre.to_sym].init : @pre)
			### calculate index
			if pre.is_a?(Hash) and pre.isnull
				pre = 0
			elsif pre.nil?
				pre = -1
			else
				pre = @var.index(pre)
			end
			return "#{@var.id} #{pre}" if is_prevail

			### resolve reference
			post = ((@post.is_a?(String) and @post.isref) ? variables[@post.to_sym].init : @post)
			### calculate index
			if post.is_a?(Hash) and post.isnull
				"0 #{@var.id} #{pre} 0"
			else
				"0 #{@var.id} #{pre} #{@var.index(post)}"
			end
		end

		def dump(stream, root, variables, is_prevail=true)
			### resolve reference
			pre = ((@pre.is_a?(String) and @pre.isref) ? variables[@pre.to_sym].init : @pre)
			### calculate index
			if pre.is_a?(Hash) and pre.isnull
				pre = 0
			elsif pre.nil?
				pre = -1
			else
				pre = @var.index(pre)
			end

			line = nil
			if is_prevail
				line = "#{@var.id} #{pre}\n"
			else
				### resolve reference
				post = ((@post.is_a?(String) and @post.isref) ? variables[@post.to_sym].init : @post)
				### calculate index
				if post.is_a?(Hash) and post.isnull
					line = "0 #{@var.id} #{pre} 0\n"
				else
					line = "0 #{@var.id} #{pre} #{@var.index(post)}\n"
				end
			end

			raise TranslationException if line[-2] == ' '
			stream.write line
		end

		def to_s
			return @var.name + ',' +
				(@pre == nil ? '-' : (@pre.is_a?(Hash) ? @pre.tostring : @pre.to_s)) + ',' +
				(@post == nil ? '-' : (@post.is_a?(Hash) ? @post.tostring : @post.to_s))
		end

		def to_sfw
			pre = @pre
			pre = @pre.ref if @pre.is_a?(Hash) and @pre.isobject
			pre = Sfp::Null.new if @pre.is_a?(Hash) and @pre.isnull

			post = @post
			post = @post.ref if @post.is_a?(Hash) and @post.isobject
			post = Sfp::Null.new if @post.is_a?(Hash) and @post.isnull

			return {
					'name' => @var.name,
					'pre' => pre,
					'post' => post
				}
		end
	end

end
