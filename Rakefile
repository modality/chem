require 'rake/clean'		
require 'rubygems'		
require 'rubygems/package_task'

spec = eval(File.read('chem.gemspec'))		
		
Gem::PackageTask.new(spec) do |pkg|		
end

task :install do
  `rake gem`
  `sudo gem uninstall chem`
  `sudo gem install pkg/chem-#{Chem::VERSION}.gem`
  `rake clobber`
end
