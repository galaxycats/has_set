# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{has_set}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["pkw.de Dev Team"]
  s.date = %q{2009-04-16}
  s.description = %q{A simple Gem to enable any `ActiveRecord::Base` object to store a set of attributes in a set like structure represented through a bitfield on the database level.  You only have to specify the name of the set to hold the attributes in question an the rest is done for you through some fine selected Ruby magic. Here is a simple example of how you could use the gem:  class Person < ActiveRecord::Base has_set :interests end  To get this to work you need some additional work done first:  1. You need an unsigned 8-Byte integer column in your database to store the bitfield. It is expected that the column is named after the name of the set with the suffix `_bitfield` appended (e.g. `interests_bitfield`). You can change that default behavior by providing the option `:column_name` (e.g. `has_set :interests, :column_name => :my_custom_column`). 2. You need a class that provides the valid values to be stored within the set and map the single bits back to something meaningful. The class should be named after the name of the set (you can change this through the `:enum_class` option). This class could be seen as an enumeration and must implement the following simple interface: * There must be a class method `values` to return all valid enumerators in the defined enumeration. * Each enumerator must implement a `name` method to return a literal representation for identification. The literal must be of the type `String`. * Each enumerator must implement a `bitfield_index` method to return the exponent of the number 2 for calculation the position of this enumerator in the bitfield. **Attention** Changing this index afterwards will destroy your data integrity.  Here is a simple example of how to implement such a enumeration type while using the the `renum` gem for simplicity. You are free to use anything else that matches the described interface.  enum :Interests do attr_reader :bitfield_index  Art(0) Golf(1) Sleeping(2) Drinking(3) Dating(4) Shopping(5)  def init(bitfield_index) @bitfield_index = bitfield_index end end}
  s.email = ["dev@pkw.de"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = [".git/COMMIT_EDITMSG", ".git/HEAD", ".git/config", ".git/description", ".git/hooks/applypatch-msg.sample", ".git/hooks/commit-msg.sample", ".git/hooks/post-commit.sample", ".git/hooks/post-receive.sample", ".git/hooks/post-update.sample", ".git/hooks/pre-applypatch.sample", ".git/hooks/pre-commit.sample", ".git/hooks/pre-rebase.sample", ".git/hooks/prepare-commit-msg.sample", ".git/hooks/update.sample", ".git/index", ".git/info/exclude", ".git/logs/HEAD", ".git/logs/refs/heads/master", ".git/objects/0a/bae2b8e5d008e33a9d6625b607acf4deda1b66", ".git/objects/0c/6117d9fb83be5d944c757c10508e44b4cf2b30", ".git/objects/14/a92f021affaba718f7fa7ff0dbd01fa6399170", ".git/objects/1f/61aec546595a2ef66c74a06e7bd7d971e28d4e", ".git/objects/33/3970c1607b005e3ed56420b8fe2ea3d354a1b7", ".git/objects/34/413f36507e54f29cabae523b5aeda3fd725f13", ".git/objects/38/919ba06643a10a6ca3b1195db336f1f52dbd8f", ".git/objects/38/b401d58d7780459487112f079f6291392713b3", ".git/objects/3d/e1a86210618b9358f3908a2510cf312708ac6c", ".git/objects/45/ea5cd126e5c66a1b0184f042421c66318977fb", ".git/objects/55/3f76ca84297719f8f7870b19864a98635a6d16", ".git/objects/5d/9cbcf5ba2d8026df65a90d3928c4fba08e9d80", ".git/objects/74/31c003e8c653caa79fdfc1e5c4c2f71f3ac3ac", ".git/objects/88/0d2f280d07f4c63e6df323233a3a5cf1ed34d2", ".git/objects/8e/3c48f376bbd50952da07da38038ae0d3a8c0d2", ".git/objects/9a/fd39830045658133cf42ee7bfa5274427ad14c", ".git/objects/9c/ce3f4bad3155e0ec7a37b67ccaac684054b87f", ".git/objects/9f/000c5705951fccb43fab5d5e88a55d032ef9e9", ".git/objects/9f/392dfd3d65829bc26f5a0b05a367e2f4e78a64", ".git/objects/a8/38d077819b1a9ed9634d5ae4a563fb93d6341e", ".git/objects/b0/742b4fe26af7869f68c9a2fd3e7b7cebdcb067", ".git/objects/c2/7f6559350f7adb19d43742b55b2f91d07b6550", ".git/objects/cf/326e51891e1cb8e901b194d7571cbf64472800", ".git/objects/e4/8464df56bf487e96e21ea99487330266dae3c9", ".git/objects/ff/d4c6ee992a1c50bcab6c8dacf1cc5d13481eea", ".git/refs/heads/master", ".gitignore", "History.txt", "Manifest.txt", "README.txt", "Rakefile", "has_set.gemspec", "lib/has_set.rb", "pkwde-has_set.gemspec", "script/console", "script/destroy", "script/generate", "test/has_set_test.rb", "test/test_helper.rb"]
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
