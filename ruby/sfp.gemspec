Gem::Specification.new do |s|
	s.name			= 'sfp'
	s.version		= File.read(File.dirname(__FILE__) + '/VERSION').strip
	s.date			= File.atime(File.dirname(__FILE__) + '/VERSION').strftime("%Y-%m-%d").to_s
	s.summary		= 'SFP Parser'
	s.description	= 'A Ruby API and script for SFP language parser'
	s.authors		= ['Herry']
	s.email			= 'herry13@gmail.com'

	s.executables << 'sfp'
	s.files			= `git ls-files`.split("\n").select { |n| !(n =~ /^test\/.*/) }

	s.require_paths = ['lib']
	s.license       = 'BSD'

	s.homepage		= 'https://github.com/herry13/sfp-ruby'
	s.rubyforge_project = 'sfp'

	s.add_dependency 'antlr3', '~> 1.10.0'

	s.add_development_dependency 'rake'
end	
