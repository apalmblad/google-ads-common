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
# This example gets all active content categorized as "comedy" using the
# network's content browse custom targeting key.
#
# This feature is only available to DFP video publishers.
#
# Tags: NetworkService.getCurrentNetwork,
#       ContentService.getContentByStatementAndCustomTargetingValue
#       CustomTargetingService.getCustomTargetingValuesByStatement

require 'dfp_api'

API_VERSION = :v201111
PAGE_SIZE = 500

def get_content_by_statement()
  # Get DfpApi instance and load configuration from ~/dfp_api.yml.
  dfp = DfpApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # dfp.logger = Logger.new('dfp_xml.log')

  # Get the NetworkService.
  network_service = dfp.service(:NetworkService, API_VERSION)

  # Get content browse custom targeting key ID.
  current_network = network_service.get_current_network
  content_browse_custom_targeting_key_id =
      current_network[:content_browse_custom_targeting_key_id]

  # Get the CustomTargetingService.
  custom_targeting_service = dfp.service(:CustomTargetingService, API_VERSION)

  # Create a statement to select the categories matching the name comedy.
  statement = {
      :query => 'WHERE customTargetingKeyId = :targeting_key_id' +
          ' and name = :category LIMIT 1',
      :values => [
          {:key => 'targeting_key_id',
           :value => {:value => content_browse_custom_targeting_key_id,
                      :xsi_type => 'NumberValue'}},
          {:key => 'category',
           :value => {:value => 'comedy',
                      :xsi_type => 'TextValue'}},
      ]
  }

  # Get categories matching the filter statement.
  page = custom_targeting_service.get_custom_targeting_values_by_statement(
      statement)

  # Get the custom targeting value ID for the comedy category.
  category_custom_targeting_value_id = page[:results].first()[:id]

  # Get the ContentService.
  content_service = dfp.service(:ContentService, API_VERSION)

  # Define initial values.
  offset = 0
  page = {}

  statement_text = 'WHERE status = :status'
  statement = {
      :query => statement_text,
      :values => [
          {:key => 'status',
           :value => {:value => 'ACTIVE', :xsi_type => 'TextValue'}}
      ]
  }

  begin
    # Create a statement to get one page with current offset.
    statement[:query] = statement_text +
        " LIMIT %d OFFSET %d" % [PAGE_SIZE, offset]

    # Get content by statement.
    page = content_service.get_content_by_statement_and_custom_targeting_value(
        statement, category_custom_targeting_value_id)

    if page[:results]
      # Increase query offset by page size.
      offset += PAGE_SIZE

      page[:results].each_with_index do |content, index|
        puts "%d) Content ID: %d, name: %s, status: %s." % [index + start_index,
             content[:id], content[:name], content[:status]]
      end
    end
  end while offset < page[:total_result_set_size]

  # Print a footer.
  if page.include?(:total_result_set_size)
    puts "Number of results found: %d" % page[:total_result_set_size]
  end
end

if __FILE__ == $0
  begin
    get_content_by_statement()

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
