$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'activesupport'
require 'activerecord'

module HasSet
  VERSION = '0.0.1'
  
  module ClassMethods
    
    # Use like this:
    # 
    #   class Person < ActiveRecord::Base
    #     has_set :interests
    #   end
    def has_set(set_name, options = {})
      
      set_column = options.has_key?(:column_name) ? options[:column_name].to_s : "#{set_name}_bitfield"
      
      unless self.columns_hash[set_column.to_s].type == :integer
        raise ActiveRecord::ActiveRecordError, "The column '#{set_column}' to store the the set must be of type integer, because we store them in a bitfield."
      end
      
      begin
        enum_class = options.has_key?(:enum_class) ? options[:enum_class] : Object.const_get(set_name.to_s.camelcase)
      rescue NameError => ne
        raise NameError, "There ist no class to take the set entries from (#{ne.message})."
      end
      
      define_method("#{set_name}=") do |set_elements|
        if set_elements.blank?
          self[set_column] = 0
        else
          set_elements = [set_elements].flatten
          set_elements.each do |element|
            unless element.kind_of? enum_class
              raise ArgumentError, "You must provide an element of the #{enum_class} Enumeration. You provided an element of the class #{element.class}."
            end
            
            2**element.index & self[set_column] == 2**element.index ? next : self[set_column] += 2**element.index
          end
        end
      end
      
      define_method(set_name) do
        if self[set_column] == 0
          return []
        else
          enum_class.values.inject([]) do |set_elements, enum_element|
            set_elements << enum_element if send("#{set_name.to_s.singularize}_#{enum_element.name.underscore}?")
            set_elements
          end
        end
      end
      
      enum_class.values.each do |enum|
        define_method("#{set_name.to_s.singularize}_#{enum.name.underscore}?") do
          2**enum.index & self[set_column] == 2**enum.index ? true : false
        end
        
        define_method("#{set_name.to_s.singularize}_#{enum.name.underscore}=") do |true_or_false|
          current_value = (2**enum.index & self[set_column] == 2**enum.index)
          true_or_false = true  if true_or_false.to_s == "true" || (true_or_false.respond_to?(:to_i) && true_or_false.to_i == 1)
          true_or_false = false if true_or_false.to_s == "false" || (true_or_false.respond_to?(:to_i) && true_or_false.to_i == 0)

          if current_value != true_or_false
            true_or_false ? self[set_column] += 2**enum.index : self[set_column] -= 2**enum.index
          end
        end
      end
      
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
  end
  
end

ActiveRecord::Base.send :include, HasSet