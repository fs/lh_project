require 'rubygems'
require 'rake'

require "#{File.dirname(__FILE__)}/lib/lh_project/version"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "lh_project"
    gem.summary = "Create new LH project by tempalte."
    gem.email = "timur.vafin@flatsoft.com"
    gem.homepage = "http://github.com/fs/lh_project"
    gem.authors = ["Timur Vafin"]
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = LhProject::VERSION::STRING
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "lh_project #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/lh_project/*.rb')
end

