require 'rubygems'
require 'json'

module Sfp

	# sfp::undefined
	Undefined = Object.new
	def Undefined.to_s
		'Undefined'
	end
	
	# sfp::unknown
	Unknown = Object.new
	def Unknown.to_s
		'Unknown'
	end
	
	# method to create a visitor object
	def visitor
		object = Object.new
		def object.set_proc(p)
			@proc = p
		end
		def object.visit(name, value, parent)
			return false if @proc.nil?
			@proc.call(name, value, parent)
		end
		object.set_proc(block_given? ? Proc.new : nil)
		object
	end

end

# convert SFP to JSON
Hash.send(:define_method, "to_json") {
	v = visitor { |name,value,parent|
		parent.delete('_parent') if parent.has_key?('_parent')
		true
	}
	clone = self.deep_clone
	JSON.generate(clone.accept(v))
}

# deep clone of current Hash
Hash.send(:define_method, "deep_clone") {
	def helper(value)
		if value.is_a?(Hash)
			result = value.clone
			value.each { |k,v|
				if k != '_parent'
					result[k] = helper(v)
					result[k]['_parent'] = result if result[k].is_a?(Hash) and result[k].has_key?('_parent')
				end
			}
			result
		elsif value.is_a?(Array)
			result = Array.new
			value.each { |v| result << helper(v) }
			result
		else
			value
		end
	end
	helper(self)
}

# return the reference of current object
Hash.send(:define_method, "ref") {
	return '$' if !self['_parent'].is_a?(Hash) or !self.has_key?('_self')
	return "#{self['_parent'].ref}.#{self['_self']}"
}

# accept visitor object - see Visitor pattern
Hash.send(:define_method, "accept") { |visitor|
	if visitor.respond_to?(:visit)
		self.keys.each do |key|
			next if key == '_parent' or !self.has_key?(key)
			value = self[key]
			value.accept(visitor) if visitor.visit(key, value, self) and value.is_a?(Hash)
		end
	end
	self
}

# return the value of given reference
Hash.send(:define_method, "at?") { |ref|
	return self if ref.nil?
	return Undefined if !ref.is_a?(String)
	first, rest = ref.split('.', 2)
	if first == '$' or first == 'root'
		self.root.at?(rest)
	elsif first == 'this' or first == 'self'
		self.at?(rest)
	elsif first == 'parent'
		if !self['_parent'].is_a?(Hash)
			nil
		else
			self['_parent'].at?(rest)
		end
	elsif self.has_key?(first)
		if rest.nil?
			self[first]
		elsif self[first].is_a?(Hash)
			self[first].at?(rest)
		else
			Undefined
		end
	else
		Undefined
	end
}

# return root of given SFP
Hash.send(:define_method, "root") {
	return self if !self.has_key?('_parent') or !self['_parent'].is_a?(Hash)
	self['_parent'].root
}

Hash.send(:define_method, "is?") { |context|
	# context => schema, object, constraint, procedure, state
	(self['_context'] == context)
}

# add path to the end of a reference 
String.send(:define_method, "push") { |value|
	return self.to_s + "." + value
}

# return an array of [ parent, last_element ]
String.send(:define_method, 'pop') {
	return self if not self.ref?
	parts = self.split('.')
	return self if parts.length <= 1
	last = parts[ parts.length - 1 ]
	len = self.length - last.length - 1
	return [self[0, len], last]
}

# return true if this string is a reference, otherwise false
String.send(:define_method, 'ref?') {
	s = self.to_s
	return true if (s.length > 0 and s[0,2] == '$.')
	return false
}

# return true if this is an SFP:Reference
String.send(:define_method, 'reference?') {
	self =~ /^\$\.[a-zA-Z]+(\.[a-zA-Z]+)*$/
}

# return true if this is an SFP:String
String.send(:define_method, 'string?') {
	self =~ /^(?!\$\.).*/
}

# return the prefix of this path
# e.g.: if self == 'a.b.c.d', it will return 'a.b.c'
String.send(:define_method, 'prefix') {
	return self if self == '$'
	parts = self.split('.')
	return self[0, self.length - parts[parts.length-1].length - 1]
}

# simplify a reference by removing unnecessary 'parent'
String.send(:define_method, 'simplify') {
	return self if not self.ref?
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

# conversion from JSON to SFP
String.send(:define_method, "to_sfp") {
	v = visitor { |name,value,parent|
		value['_parent'] = parent if value.is_a?(Hash)
		true
	}
	sfp = JSON[self]
	sfp.accept(v)
}


