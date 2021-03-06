module Sfp
	module Visitor
		# An example of class Visitor which can be used to traverse from one node to
		# another node (bread first). This is based on 'Visitor' pattern.
		class Default
			def visit(name, value, parent); end
		end

		class ConformantVariables
			attr_reader :var_values
			def initialize
				@var_values = {}
			end

			def visit(name, value, parent)
				if value.is_a?(Hash) and value.iseither
					ref = parent.ref.push(name)
					@var_values[ref] = value['_values']
				end
				return true if value.is_a?(Hash) and value.isobject
				false
			end
		end

		# eliminate '_parent' key/value from a Hash object to avoid cyclic references
		class ParentEliminator
			def visit(name, value, parent)
				value.delete('_parent') if value.is_a?(Hash) and value.has_key?('_parent')
				return true
			end
		end

		class AbstractEliminator
			def visit(name, value, parent)
				parent.delete(name) if value.is_a?(Hash) and value['_context'] == 'abstract'
				true
			end
		end

		class ParentGenerator
			def visit(name, value, parent)
				value['_parent'] = parent if value.is_a?(Hash)
				return true
			end
		end

		class ProcedureEliminator
			def visit(name, value, parent)
				if value.is_a?(Hash) and value.isprocedure
					parent.delete(name)
					return false
				end
				true
			end
		end

		class PrettyStateGenerator
			def visit(name, value, parent)
				if name[0,1] == '_'
					parent.delete(name)
				elsif value.is_a?(Hash)
					if value.isnull
						parent[name] = nil
						return false
					else
						parent.delete(name) if value['_context'] == 'procedure' or
								value['_context'] == 'constraint'
					end
				end
				true
			end
		end

		class SfpGenerator
			def initialize(root)
				@root = root
			end

			def visit(name, value, parent)
				if value.is_a?(Hash)
					value['_parent'] = parent
					value['_self'] = name
					if not value.has_key?('_context')
						value['_context'] = 'object'
						if value.has_key?('_isa')
						else
							value['_isa'] = '$.Object'
						end
					end
					Sfp::Helper.expand_object(value, @root) if value.isobject
				end
				return true
			end
		end

		class ReferenceModifier
			def visit(name, value, parent)
				if value.is_a?(String) and value.isref and parent.isobject
					if	value.length >= 8 and value[0,8] == '$.parent'
						_, _, rest = value.split('.', 3)
						if parent.has_key?('_parent')
							val = parent['_parent'].ref
							val << ".#{rest}" if not rest.nil?
							parent[name] = val
						else
							raise Exception
						end
					elsif value.length >= 6 and value[0,6] == '$.this'
						_, _, rest = value.split('.', 3)
						val = parent.ref
						val << ".#{rest}" if not rest.nil?
						parent[name] = val
					end
				end
				true
			end
		end

		class SetModifier
			def visit(name, value, parent)
				return false if value.is_a?(Hash) and value.isprocedure

				if value.is_a?(Hash) and value.isset
					parent[name] = []
					return false
				end
				true
			end
		end

		class NullModifier
			def visit(name, value, parent)
				return false if value.is_a?(Hash) and value.isprocedure

				if value.is_a?(Hash) and value.isnull
					parent[name] = nil
					return false
				end
				true
			end
		end
	end
end
