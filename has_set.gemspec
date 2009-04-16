# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{has_set}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["pkw.de Dev Team"]
  s.date = %q{2009-04-16}
  s.description = %q{A simple Gem to enable any `ActiveRecord::Base` object to store a set of attributes in a set like structure represented through a bitfield on the database level.  You only have to specify the name of the set to hold the attributes in question an the rest is done for you through some fine selected Ruby magic. Here is a simple example of how you could use the gem:  class Person < ActiveRecord::Base has_set :interests end  To get this to work you need some additional work done first:  1. You need an unsigned 8-Byte integer column in your database to store the bitfield. It is expected that the column is named after the name of the set with the suffix `_bitfield` appended (e.g. `interests_bitfield`). You can change that default behavior by providing the option `:column_name` (e.g. `has_set :interests, :column_name => :my_custom_column`). 2. You need a class that provides the valid values to be stored within the set and map the single bits back to something meaningful. The class should be named after the name of the set (you can change this through the `:enum_class` option). This class could be seen as an enumeration and must implement the following simple interface: * There must be a class method `values` to return all valid enumerators in the defined enumeration. * Each enumerator must implement a `name` method to return a literal representation for identification. The literal must be of the type `String`. * Each enumerator must implement a `bitfield_index` method to return the exponent of the number 2 for calculation the position of this enumerator in the bitfield. **Attention** Changing this index afterwards will destroy your data integrity.  Here is a simple example of how to implement such a enumeration type while using the the `renum` gem for simplicity. You are free to use anything else that matches the described interface.  enum :Interests do attr_reader :bitfield_index  Art(0) Golf(1) Sleeping(2) Drinking(3) Dating(4) Shopping(5)  def init(bitfield_index) @bitfield_index = bitfield_index end end}
  s.email = ["dev@pkw.de"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "has_set.gemspec", "lib/has_set.rb", "script/console", "script/destroy", "script/generate", "test/has_set_test.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/pkwde/has_set}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{has_set}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A Gem that enables ActiveRecord models to have a set of values defined in a certain class and stored in an integer bitfield on the database level.}
  s.test_files = ["test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["= 2.2.2"])
      s.add_runtime_dependency(%q<activesupport>, ["= 2.2.2"])
      s.add_development_dependency(%q<newgem>, [">= 1.3.0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<pkwde-renum>, [">= 0"])
      s.add_development_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<activerecord>, ["= 2.2.2"])
      s.add_dependency(%q<activesupport>, ["= 2.2.2"])
      s.add_dependency(%q<newgem>, [">= 1.3.0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<pkwde-renum>, [">= 0"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<activerecord>, ["= 2.2.2"])
    s.add_dependency(%q<activesupport>, ["= 2.2.2"])
    s.add_dependency(%q<newgem>, [">= 1.3.0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<pkwde-renum>, [">= 0"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
