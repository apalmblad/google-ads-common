# Encoding: utf-8
#
# Author:: api.dklimkin@gmail.com (Danial Klimkin)
#
# Copyright:: Copyright 2010, Google Inc. All Rights Reserved.
#
# License:: Licensed under the Apache License, Version 2.0 (the "License");
#           you may not use this file except in compliance with the License.
#           You may obtain a copy of the License at
#
#           http://www.apache.org/licenses/LICENSE-2.0
#
#           Unless required by applicable law or agreed to in writing, software
#           distributed under the License is distributed on an "AS IS" BASIS,
#           WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
#           implied.
#           See the License for the specific language governing permissions and
#           limitations under the License.
#
# Code template for registry generation for Savon backend

require 'savon'
require 'ads_common/build/savon_abstract_generator'
require 'pp'

module AdsCommon
  module Build
    class SavonRegistryGenerator < SavonAbstractGenerator
      REGISTRY_TEMPLATE = %q{<% %>
      # Encoding: utf-8
      #
      # This is auto-generated code, changes will be overwritten.
      #
      # Copyright:: Copyright 2012, Google Inc. All Rights Reserved.
      # License:: Licensed under the Apache License, Version 2.0.
      #
      # <%= @generator_stamp %>

      require '<%= @api_name.snakecase %>/errors'

      <%= @modules_open_string %>

        class <%= @service_name %>Registry
          <%= @service_name.upcase %>_METHODS = <%= format_signature(@methods) %>
          <%= @service_name.upcase %>_TYPES = <%= format_signature(@types) %>
          <%= @service_name.upcase %>_NAMESPACES = <%= format_array(@namespaces) %>

          def self.get_method_signature(method_name)
            return <%= @service_name.upcase %>_METHODS[method_name.to_sym]
          end

          def self.get_type_signature(type_name)
            return <%= @service_name.upcase %>_TYPES[type_name.to_sym]
          end

          def self.get_namespace(index)
            return <%= @service_name.upcase %>_NAMESPACES[index]
          end
        end
        <% @exceptions.each do |exception| %>
          <% array_fields = [] %>

          <% doc_lines = format_doc(exception[:doc]) %>
          <% doc_lines.each do |doc_line| %>
        # <%= doc_line %>
          <% end %>
          <% base_text = (exception[:base].nil?) ? @default_exception_base : exception[:base] %>
        class <%= exception[:name] %> < <%= base_text  %>
          <% exception[:fields].each do |field| %>
          attr_reader :<%= field[:name] %>  # <%= field[:type] %>
            <% is_array_field = (field[:max_occurs].nil?) ? false :
                   ((field[:max_occurs] == :unbounded) || (field[:max_occurs] > 1)) %>
            <% array_fields << field[:name] if is_array_field %>
          <% end %>
          <% if !(array_fields.empty?) %>
          def initialize(exception_fault)
            @array_fields ||= []
            <% array_fields.each do |field| %>
            @array_fields << '<%= field.to_s %>'
            <% end %>
            super(exception_fault)
          end
          <% end %>
        end
        <% end %>
      <%= @modules_close_string %>

      }.gsub(/^      /, '')

      def initialize(args)
        super(args)
        @exceptions = []
        @methods = []
        @types = []
        @namespaces = []
        @default_exception_base = "%s::Errors::ApiException" % @api_name
      end

      def get_code_template()
        REGISTRY_TEMPLATE
      end

      def add_exceptions(exceptions)
        @exceptions += exceptions
      end

      def add_methods(methods)
        @methods += methods
      end

      def add_types(types)
        @types += types
      end

      def add_namespaces(namespaces)
        @namespaces += namespaces
      end

      private

      # Multi-line documentation formatter. Used to format text extracted from
      # XML into stripped multi-line text.
      def format_doc(doc)
        res = []
        doc.split(/\n/).each do |line|
          line = line.strip();
          res << line if !(line.empty?)
        end
        return res
      end

      # Prepares a hash string based on array of hashes passed.
      def format_signature(objects_array)
        objects_hash = get_hash_for_names_array(objects_array)
        return PP.singleline_pp(objects_hash, '')
      end

      # Prepares string representing a simple array.
      def format_array(objects_array)
        return (objects_array.nil?) ? '[]' : PP.singleline_pp(objects_array, '')
      end

      # Converts an array of hashes to a hash based on ":name" fields:
      # [{:name => 'foo', :data => 'bar'}] => {:foo => {:data => 'bar'}}
      def get_hash_for_names_array(input)
        return input.inject({}) do |output, e|
          key = e[:name].to_sym
          output[key] = e.reject {|k, v| k.equal?(:name)}
          output
        end
      end
    end
  end
end
