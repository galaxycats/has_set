= has_set

* http://github.com/pkwde/has_set

== DESCRIPTION:

A simple Gem to enable any `ActiveRecord::Base` object to store a set of attributes in a set like structure represented through a bitfield on the database level.

You only have to specify the name of the set to hold the attributes in question an the rest is done for you through some fine selected Ruby magic. Here is a simple example of how you could use the gem:

    class Person < ActiveRecord::Base
      has_set :interests
    end

To get this to work you need some additional work done first:

  1. You need an unsigned 8-Byte integer column in your database to store the bitfield. It is expected that the column is named after the name of the set with the suffix `_bitfield` appended (e.g. `interests_bitfield`). You can change that default behavior by providing the option `:column_name` (e.g. `has_set :interests, :column_name => :my_custom_column`).
  2. You need a class that provides the valid values to be stored within the set and map the single bits back to something meaningful. The class should be named after the name of the set (you can change this through the `:enum_class` option). This class could be seen as an enumeration and must implement the following simple interface:
    * There must be a class method `values` to return all valid enumerators in the defined enumeration.
    * Each enumerator must implement a `name` method to return a literal representation for identification. The literal must be of the type `String`.
    * Each enumerator must implement a `bitfield_index` method to return the exponent of the number 2 for calculation the position of this enumerator in the bitfield. **Attention** Changing this index afterwards will destroy your data integrity.

Here is a simple example of how to implement such a enumeration type while using the the `renum` gem for simplicity. You are free to use anything else that matches the described interface.
    
    enum :Interests do
      attr_reader :bitfield_index

      Art(0)
      Golf(1)
      Sleeping(2)
      Drinking(3)
      Dating(4)
      Shopping(5)

      def init(bitfield_index)
        @bitfield_index = bitfield_index
      end
    end
    

== REQUIREMENTS:

* `ActiveRecord`
* `ActiveSupport`
* `pkwde-renum` (*optionally*)

== INSTALL:

    sudo gem install pkwde-has_set --source http://gems.github.com

== LICENSE:

(The MIT License)

Copyright (c) 2009 pkw.de Dev Team

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.