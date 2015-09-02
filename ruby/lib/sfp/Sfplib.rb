module Sfp
	module SfpLangHelper
		attr_accessor :root_dir, :home_dir, :constraint_next_id
		attr_reader :root, :used_classes, :arrays, :conformant

		def init
			@root = Hash.new
			@now = @root
			@root['Object'] = { '_self' => 'Object', '_context' => 'class', '_parent' => @root }
			@unexpanded_classes = Array.new
			@used_classes = Array.new
			@arrays = Hash.new
			@conformant = false
		end

		def finalize
			#@root.keys.each { |k|
			#	next if k[0,1] == '_' or !@root[k].is_a?(Hash)
			#	@root.delete(k) if @root[k]['_context'] == 'abstract'
			#}
		end

		def next_id
			nid = "c#{@constraint_next_id}"
			@constraint_next_id += 1
			return nid
		end
	
		def null_value(isa=nil)
			return { '_context' => 'null', '_isa' => isa }
		end
	
		def to_ref(path)
			ref = "$." + path
			return ref
		end
	
		def to_sfp
			return @root
		end

		def create_constraint(name, type='and')
			return { '_self' => name,
				'_context' => 'constraint',
				'_type' => type,
				'_parent' => @now
			}
		end

		def process_file(file)
			filepath = file
			filepath = @root_dir + "/" + file if not @root_dir.nil? and file[0,1] != '/'
			filepath = @home_dir + "/" + file if not @home_dir.nil? and not File.exist?(filepath)

			raise Exception, 'File not found: ' + file if not File.exist?(filepath)

			parser = Sfp::Parser.new({ :root_dir => @root_dir,
			                           :home_dir => File.expand_path(File.dirname(filepath)),
			                           :constraint_next_id => @constraint_next_id })
			parser.parse(File.read(filepath), {:keep_abstract => true})
			parser.root.each_pair do |key,val|
				if val.is_a?(Hash)
					if val['_context'] == 'state' and @root.has_key?(key) and @root[key]['_context'] == 'state'
						val.each_pair { |k2,v2| @root[key][k2] = v2 if k2[0,1] != '_' }
					elsif val['_context'] == 'constraint' and @root.has_key?(key) and @root[key]['_context'] == 'constraint'
						val.each_pair { |k2,v2| @root[key][k2] = v2 if k2[0,1] != '_' }
					else
						@root[key] = val
						val['_parent'] = @root if val['_context'] != 'state'
					end
				else
					@root[key] = val
				end
			end
			@constraint_next_id = parser.constraint_next_id
		end
	
		def goto_parent(remove_parent=false)
			n = @now
			@now = @now['_parent']
			n.delete('_parent') if remove_parent
			return n
		end

		def expand_class(c)
			sclass = @root.at?(c['_extends'])
			c.inherits( sclass )
			c['_super'] = (sclass.has_key?('_super') ? sclass['_super'].clone : Array.new)
			c['_super'] << c['_extends']
			if sclass['_finals'].is_a?(Array)
				if c['_finals'].is_a?(Array)
					c['_finals'].concat(sclass['_finals'])
				else
					c['_finals'] = sclass['_finals']
				end
			end
		end

		def expand_classes
			@unexpanded_classes.each { |c| expand_class(c) }
		end

		def expand_object(obj)
			return false if not Sfp::Helper.expand_object(obj, @root)
			@used_classes = @used_classes.concat(obj['_classes']).uniq
		end

		def deep_clone(value)
			Sfp::Helper.deep_clone(value)
		end
	end

	module Helper
		def self.deep_clone(value)
			if value.is_a?(Hash)
				result = value.clone
				value.each { |k,v|
					if k != '_parent'
						result[k] = deep_clone(v)
						result[k]['_parent'] = result if result[k].is_a?(Hash) and result[k].has_key?('_parent')
					end
				}
				result
			elsif value.is_a?(Array)
				result = Array.new
				value.each { |v| result << deep_clone(v) }
				result
			else
				value
			end
		end

		def self.to_json(sfp)
			root = Sfp::Helper.deep_clone(sfp)
			root.accept(Sfp::Visitor::ParentEliminator.new)
			return JSON.generate(root)
		end

		def self.to_pretty_json(sfp)
			root = Sfp::Helper.deep_clone(sfp)
			root.accept(Sfp::Visitor::ParentEliminator.new)
			return JSON.pretty_generate(root)
		end

		def self.expand_object(obj, root)
			return false if obj == nil or root == nil or
					not obj.has_key?('_isa') or obj['_isa'] == nil
			objclass = root.at?(obj['_isa'])
			if objclass.nil? or objclass.is_a?(Sfp::Unknown) or objclass.is_a?(Sfp::Undefined)
				raise Exception, "Schema #{obj['_isa']} of object #{obj['_self']} is not found!"
			end
			obj.inherits( objclass )
			obj['_classes'] = (objclass.has_key?('_super') ? objclass['_super'].clone : Array.new)
			obj['_classes'] << obj['_isa']

			if objclass['_finals'].is_a?(Array)
				if obj['_finals'].is_a?(Array)
					obj['_finals'].concat(objclass['_finals'])
				else
					obj['_finals'] = objclass['_finals']
				end
			end

			return true
		end
	end


	class Null
		attr_accessor :type
	end

	# Instance of this class will be returned as the value of a non-exist variable
	class Undefined
		def self.create(type)
			@@list = {} if !defined? @@list
			return @@list[type] if @@list.has_key?(type)
			(@@list[type] = Undefined.new(nil, type))
		end

		attr_accessor :path, :type
		def initialize(path=nil, type=nil)
			@path = path
			@type = type
		end

		def to_s
			(@type.nil? ? "$.Undefined" : "$.Undefined.#{@type}")
		end
	end

	# Instance of this class will be return as the value of an unknown variable
	# in open-world assumption.
	class Unknown
		def self.create(type)
			@@list = {} if !defined? @@list
			return @@list[type] if @@list.has_key?(type)
			(@@list[type] = Unknown.new(nil, type))
		end

		attr_accessor :path, :type
		def initialize(path=nil, type=nil)
			@path = path
			@type = type
		end

		def to_s
			(@type.nil? ? "$.Unknown" : "$.Unknown.#{@type}")
		end
	end

	class Any
		def to_s; '<sfp::any>'; end
	end
end

# return a fullpath of reference of this context
Hash.send(:define_method, "ref") {
	return '$' if not self.has_key?('_parent') or self['_parent'] == nil
	me = (self.has_key?('_self') ? self['_self'] : '')
	r = self['_parent'].ref
	r << ".#{me}"
}

# accept method as implementation of Visitor pattern
Hash.send(:define_method, "accept") { |visitor|
	keys = self.keys
	keys.each do |key|
		next if key == '_parent' or not self.has_key?(key)
		value = self[key]
		go_next = visitor.visit(key, value, self)
		value.accept(visitor) if value.is_a?(Hash) and go_next == true
	end
}

# resolve a reference, return nil if there's no value with given address
Hash.send(:define_method, "at?") { |addr|
	return Sfp::Unknown.new if not addr.is_a?(String)

	addrs = addr.split('.', 2)

	if addrs[0] == '$'
		return self.root.at?(addrs[1])
	elsif addrs[0] == 'root'
		return self.root.at?(addrs[1])
	elsif addrs[0] == 'this' or addrs[0] == 'self'
		return self.at?(addrs[1])
	elsif addrs[0] == 'parent'
		return nil if not self.has_key?('_parent')
		return self['_parent'] if addrs[1].nil?
		return self['_parent'].at?(addrs[1])
	elsif self.has_key?(addrs[0])
		if addrs.length == 1 
			return self[addrs[0]]
		else
			return self[addrs[0]].at?(addrs[1]) if self[addrs[0]].is_a?(Hash) and addrs[1] != ''
		end
	end

	return Sfp::Unknown.new
}

Hash.send(:define_method, "type?") { |name|
	return nil if not self.has_key?(name)
	value = self[name]
	if value != nil
		return '$.Boolean' if value.is_a?(TrueClass) or value.is_a?(FalseClass)
		return '$.Integer' if value.is_a?(Numeric)
		return '$.String' if value.is_a?(String) and not value.isref
		return value['_isa'] if value.isobject or value.isnull
		return "(#{value['_isa']})" if value.is_a?(Hash) and value.isset and value.has_key?('_isa')
	end

	return nil
}

# return root context of this context
Hash.send(:define_method, "root") {
	return self if not self.has_key?('_parent') or self['_parent'] == nil
	return self['_parent'].root
}

# return true if this context is a constraint, otherwise false
Hash.send(:define_method, "isconstraint") {
	return (self.has_key?('_context') and self['_context'] == 'constraint')
}

Hash.send(:define_method, "isset") {
	return (self.has_key?('_context') and self['_context'] == 'set')
}

Hash.send(:define_method, "isprocedure") {
	return (self.has_key?('_context') and self['_context'] == 'procedure')
}

# return true if this context is a class, otherwise false
Hash.send(:define_method, "isclass") {
	return (self.has_key?('_context') and self['_context'] == 'class')
}

# return superclass' reference if this context is a sub-class, otherwise nil
Hash.send(:define_method, "extends") {
	return self['_extends'] if self.isclass and self.has_key?('_extends')
	return nil
}

# return true if this class has been expanded, otherwise false
Hash.send(:define_method, "expanded") {
	@expanded = false if not defined?(@expanded)
	return @expanded
}

# copy attributes and procedures from superclass to itself
Hash.send(:define_method, 'inherits') { |parent|
	return if not parent.is_a?(Hash)
	parent.each_pair { |key,value|
		next if key[0,1] == '_' or self.has_key?(key)
		if value.is_a?(Hash)
			self[key] = Sfp::Helper.deep_clone(value)
			self[key]['_parent'] = self
		else
			self[key] = value
		end
	}
	@expanded = true
}

# return true if this context is an object, otherwise false
Hash.send(:define_method, 'isobject') {
	return (self.has_key?('_context') and self['_context'] == 'object')
}

Hash.send(:define_method, 'isa') {
	return nil if not self.isobject or not self.has_key?('_isa')
	return self['_isa']
}

Hash.send(:define_method, 'isvalue') {
	return self.isobject
}

Hash.send(:define_method, 'isnull') {
	return (self.has_key?('_context') and self['_context'] == 'null')
}

Hash.send(:define_method, 'iseither') {
	return (self['_context'] == 'either')
}

Hash.send(:define_method, 'tostring') {
	return 'null' if self.isnull
	return self.ref
}

# add path to the end of a reference 
String.send(:define_method, "push") { |value|
	return self.to_s + "." + value
}

# return first element and keep the rest
String.send(:define_method, 'explode') {
	return self.split('.', 2)
}

# return an array of [ parent, last_element]
String.send(:define_method, 'pop_ref') {
	return self.extract
}

# return an array of [ parent, last_element ]
String.send(:define_method, 'extract') {
	return self if not self.isref
	parts = self.split('.')
	return self if parts.length <= 1
	last = parts[ parts.length - 1 ]
	len = self.length - last.length - 1
	return [self[0, len], last]
}


# return true if this string is a reference, otherwise false
String.send(:define_method, 'isref') {
	(self =~ /^\$\.[a-zA-Z_]/)
}

# return the parent of this path
# e.g.: if self == 'a.b.c.d', it will return 'a.b.c'
String.send(:define_method, 'to_top') {
	return self if self == '$'
	parts = self.split('.')
	return self[0, self.length - parts[parts.length-1].length - 1]
}

String.send(:define_method, 'simplify') {
	return self if not self.isref
	ids = self.split('.')
	i = 0
	until i >= ids.length do
		if i >= 3 and ids[i] == 'parent'
			ids.delete_at(i)
			ids.delete_at(i-1)
			i -= 1
		else
			i += 1
		end
	end
	ids.join('.')
}
