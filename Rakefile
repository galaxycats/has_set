require 'rubygems' unless ENV['NO_RUBYGEMS']
%w[rake rake/clean fileutils newgem rubigen].each { |f| require f }
require File.dirname(__FILE__) + '/lib/has_set'

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.new('has_set', HasSet::VERSION) do |p|
  p.developer('pkw.de Dev Team', 'dev@pkw.de')
  p.changes              = p.paragraphs_of("History.txt", 0..1).join("\n\n")
  p.extra_deps         = [
    ['activerecord', '= 2.2.2'],
    ['activesupport', '= 2.2.2']
  ]
  p.extra_dev_deps = [
    ['newgem', ">= #{::Newgem::VERSION}"],
    ['mocha'],
    ['pkwde-renum'],
    ['sqlite3-ruby']
  ]
  
  p.name = "pkwde-has_set"
  p.clean_globs |= %w[**/.DS_Store tmp *.log]
  p.summary = "A Gem that enables ActiveRecord models to have a set of values defined in a certain class and stored in an integer bitfield on the database level."
end

require 'newgem/tasks' # load /tasks/*.rake
Dir['tasks/**/*.rake'].each { |t| load t }

task :default => [:test]

desc "Run unit tests"
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
  t.warning = false
end