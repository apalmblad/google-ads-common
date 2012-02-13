#!/usr/bin/ruby
#
# Author:: api.dklimkin@gmail.com (Danial Klimkin)
#
# Copyright:: Copyright 2011, Google Inc. All Rights Reserved.
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
# This example gets all custom targeting keys and the values. To create custom
# targeting keys and values, run create_custom_targeting_keys_and_values.rb.
#
# Tags: CustomTargetingService.getCustomTargetingKeysByStatement,
#       CustomTargetingService.getCustomTargetingValuesByStatement

require 'dfp_api'

API_VERSION = :v201104
PAGE_SIZE = 500

def get_all_custom_targeting_keys_and_values()
  # Get DfpApi instance and load configuration from ~/dfp_api.yml.
  dfp = DfpApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # dfp.logger = Logger.new('dfp_xml.log')

  # Get the CustomTargetingService.
  custom_targeting_service = dfp.service(:CustomTargetingService, API_VERSION)

  # Define initial values.
  offset = 0
  page = {}

  begin
    # Create a statement to get one page with current offset.
    statement = {:query => "LIMIT %d OFFSET %d" % [PAGE_SIZE, offset]}

    # Get custom targeting keys by statement.
    page = custom_targeting_service.get_custom_targeting_keys_by_statement(
        statement)

    if page[:results]
      # Increase query offset by page size.
      offset += PAGE_SIZE

      # Get the start index for printout.
      start_index = page[:start_index]

      # Print details about each key in results.
      page[:results].each_with_index do |custom_targeting_key, index|
        puts ("%d) Custom targeting key ID: %d, name: %s,  displayName: %s, " +
              "type: %s") % [index + start_index,
                             custom_targeting_key[:id],
                             custom_targeting_key[:name],
                             custom_targeting_key[:display_name],
                             custom_targeting_key[:type]]
        print_all_values_for_key(custom_targeting_service, custom_targeting_key)
      end
    end
  end while offset < page[:total_result_set_size]

  # Print a footer.
  if page.include?(:total_result_set_size)
    puts "Total number of targeting keys: %d" %
        page[:total_result_set_size]
  end
end

def print_all_values_for_key(custom_targeting_service, custom_targeting_key)
  # Define initial values.
  offset = 0
  page = {}

  # Create a statement to get values for given key.
  statement_text = "WHERE customTargetingKeyId = :key_id LIMIT %d" % PAGE_SIZE
  statement = {
      :values => [
          {:key => 'key_id',
           :value => {:value => custom_targeting_key[:id],
                      :xsi_type => 'NumberValue'}}
      ]
  }

  begin
    # Modify statement to get the next page.
    statement[:query] = statement_text + " OFFSET %d" % offset

    # Get custom targeting values by statement.
    page = custom_targeting_service.get_custom_targeting_values_by_statement(
        statement)

    if page[:results]
      # Increase query offset by page size.
      offset += PAGE_SIZE

      # Get the start index for printout.
      start_index = page[:start_index]

      # Print details about each value in results.
      page[:results].each_with_index do |custom_targeting_value, index|
        puts ("\t%d) Custom targeting value ID: %d, name: %s, displayName: %s") %
            [index + start_index,
             custom_targeting_value[:id],
             custom_targeting_value[:name],
             custom_targeting_value[:display_name]]
      end
    end
  end while offset < page[:total_result_set_size]

  # Print a footer.
  if page.include?(:total_result_set_size)
    puts "\tTotal number of targeting values: %d" % page[:total_result_set_size]
  end
end

if __FILE__ == $0
  begin
    get_all_custom_targeting_keys_and_values()

  # HTTP errors.
  rescue AdsCommon::Errors::HttpError => e
    puts "HTTP Error: %s" % e

  # API errors.
  rescue DfpApi::Errors::ApiException => e
    puts "Message: %s" % e.message
    puts 'Errors:'
    e.errors.each_with_index do |error, index|
      puts "\tError [%d]:" % (index + 1)
      error.each do |field, value|
        puts "\t\t%s: %s" % [field, value]
      end
    end
  end
end
