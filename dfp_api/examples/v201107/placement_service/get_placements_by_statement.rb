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
# This example gets all active placements. The statement retrieves up to the
# maximum page size limit of 500. To create a placement, run
# create_placements.rb.
#
# Tags: PlacementService.getPlacementsByStatement

require 'dfp_api'

API_VERSION = :v201107

def get_placements_by_statement()
  # Get DfpApi instance and load configuration from ~/dfp_api.yml.
  dfp = DfpApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # dfp.logger = Logger.new('dfp_xml.log')

  # Get the PlacementService.
  placement_service = dfp.service(:PlacementService, API_VERSION)

  # Create a statement to only select active placements.
  statement = {
      :query => 'WHERE status = :status LIMIT 500',
      :values => [
          {:key => 'status',
           :value => {:value => 'ACTIVE', :xsi_type => 'TextValue'}}
      ]
  }

  # Get placements by statement.
  page = placement_service.get_placements_by_statement(statement)

  if page and page[:results]
    page[:results].each_with_index do |placement, index|
      puts "%d) Placement ID: %d, name: %s, status: %s." % [index,
          placement[:id], placement[:name], placement[:status]]
    end
  end

  # Print a footer.
  if page.include?(:total_result_set_size)
    puts "Number of results found: %d" % page[:total_result_set_size]
  end
end

if __FILE__ == $0
  begin
    get_placements_by_statement()

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
