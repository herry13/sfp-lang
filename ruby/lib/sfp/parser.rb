# main class which processes configuration description in SFP language either
# in file or as a string
class Sfp::Parser
	# enable this class to process SFP into FDR (SAS+)
	include Sfp::SasTranslator

	AbstractEliminator = Sfp::Visitor::AbstractEliminator.new

	attr_accessor :root_dir, :home_dir, :conformant
	attr_reader :root, :constraint_next_id

	def initialize(params={})
		@root_dir = (params[:root_dir].is_a?(String) ?
		             params[:root_dir].strip :
		             nil)
		@home_dir = (params[:home_dir].is_a?(String) ?
		             params[:home_dir].strip :
		             nil)
		@root = params[:root]
		@conformant = !!params[:conformant]
		@constraint_next_id = (params[:constraint_next_id] ? params[:constraint_next_id] : 0)
	end

	#####
	#
	# @param   [String] : a string of specification in SFP language
	# @options [Hash]
	#
	# @return  [Hash] : the result Hash
	#
	#####
	def parse(string, options={})
		lexer = SfpLang::Lexer.new(string)
		tokens = ANTLR3::CommonTokenStream.new(lexer)
		parser = SfpLang::Parser.new(tokens)
		parser.root_dir = @root_dir
		parser.home_dir = @home_dir
		parser.constraint_next_id = @constraint_next_id
		parser.sfp
		@constraint_next_id = parser.constraint_next_id
		@root = parser.root
		parser.root.accept(AbstractEliminator) if not options[:keep_abstract]
		@conformant = parser.conformant
		@parser_arrays = parser.arrays
		parser.root
	end

	def to_json(params={})
		return 'null' if @root.nil?
		return Sfp::Helper.to_pretty_json(@root) if params[:pretty]
		return Sfp::Helper.to_json(@root)
	end

	def self.parse_file(filepath, options={})
		options[:home_dir] = File.expand_path(File.dirname(filepath)) if !options[:home_dir]
		parser = Sfp::Parser.new(options)
		parser.parse(File.read(filepath))
	end
end
