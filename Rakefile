require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ConsistentHashr"
    gem.summary = %Q{A ruby gem to do consistent hashing}
    gem.description = %Q{A simple gem to perform consistent hashing}
    gem.email = "julien.genestoux@gmail.com"
    gem.homepage = "http://github.com/superfeedr/consistent_hashr"
    gem.authors = ["julien"]
    gem.add_development_dependency "rspec", ">= 0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ConsistentHashr #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
