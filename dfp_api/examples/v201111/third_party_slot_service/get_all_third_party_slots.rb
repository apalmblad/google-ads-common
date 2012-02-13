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
# This example gets all third party slots. To create third party slots, run
# create_third_party_slot.rb.
#
# Tags: ThirdPartySlotService.getThirdPartySlotsByStatement

require 'dfp_api'

API_VERSION = :v201111
PAGE_SIZE = 500

def get_all_third_party_slots()
  # Get DfpApi instance and load configuration from ~/dfp_api.yml.
  dfp = DfpApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # dfp.logger = Logger.new('dfp_xml.log')

  # Get the ThirdPartySlotService.
  third_party_slot_service = dfp.service(:ThirdPartySlotService, API_VERSION)

  # Define initial values.
  offset = 0
  page = {}

  begin
    # Create statement for one page with current offset.
    statement = {:query => "LIMIT %d OFFSET %d" % [PAGE_SIZE, offset]}

    # Get third party slots by statement.
    page = third_party_slot_service.get_third_party_slots_by_statement(statement)

    if page[:results]
      # Increase query offset by page size.
      offset += PAGE_SIZE

      # Get the start index for printout.
      start_index = page[:start_index]

      # Print details about each third party slot in results page.
      page[:results].each_with_index do |slot, index|
        puts "%d) Third party slot ID: %d, name: '%s'" %
            [index + start_index, slot[:id], slot[:name]]
      end
    end
  end while offset < page[:total_result_set_size]

  # Print a footer
  if page.include?(:total_result_set_size)
    puts "Total number of third party slots: %d" % page[:total_result_set_size]
  end
end

if __FILE__ == $0
  begin
    get_all_third_party_slots()

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
