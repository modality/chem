require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'

spec = eval(File.read('chem.gemspec'))
		
Gem::PackageTask.new(spec) do |pkg|
end

task :install do
  sh "rake gem"
  sh "sudo gem uninstall chem"
  sh "sudo gem install pkg/chem-#{Chem::VERSION}.gem"
  sh "rake clobber"
end
