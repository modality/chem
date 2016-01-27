# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','chem','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'chem'
  s.version = Chem::VERSION
  s.author = 'Michael Hansen'
  s.email = 'modality2@gmail.com'
  s.homepage = 'http://subtlefish.com'
  s.platform = Gem::Platform::RUBY
  s.license = 'MIT'
  s.summary = 'chem is a tool for list manipulation and shell automation'
  s.files = `git ls-files -z`.split("\x0")
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'chem'
  s.add_development_dependency('rake','~> 10.0')
  s.add_runtime_dependency('gli','2.13.4')
end
