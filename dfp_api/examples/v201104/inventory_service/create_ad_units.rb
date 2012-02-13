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
# This example creates new ad units under a the effective root ad unit. To
# determine which ad units exist, run get_inventory_tree.rb or
# get_all_ad_units.rb.
#
# Tags: InventoryService.createAdUnits

require 'dfp_api'

API_VERSION = :v201104
# Number of ad units to create.
ITEM_COUNT = 5

def create_ad_units()
  # Get DfpApi instance and load configuration from ~/dfp_api.yml.
  dfp = DfpApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # dfp.logger = Logger.new('dfp_xml.log')

  # Get the InventoryService.
  inventory_service = dfp.service(:InventoryService, API_VERSION)

  # Get the NetworkService.
  network_service = dfp.service(:NetworkService, API_VERSION)

  # Get the effective root ad unit ID of the network.
  effective_root_ad_unit_id =
      network_service.get_current_network[:effective_root_ad_unit_id]

  puts "Using effective root ad unit: %d" % effective_root_ad_unit_id

  # Create an array to store local ad unit objects.
  ad_units = (1..ITEM_COUNT).map do |index|
    {:name => "Ad_Unit_%d" % index,
     :parent_id => effective_root_ad_unit_id,
     :description => 'Ad unit description.',
     :target_window => 'BLANK',
     # Set the size of possible creatives that can match this ad unit.
     :sizes => [{:width => 300, :height => 250, :is_aspect_ratio => false}]}
  end

  # Create the ad units on the server.
  return_ad_units = inventory_service.create_ad_units(ad_units)

  if return_ad_units
    return_ad_units.each do |ad_unit|
      puts "Ad unit with ID: %d, name: %s and status: %s was created." %
          [ad_unit[:id], ad_unit[:name], ad_unit[:status]]
    end
  else
    raise 'No ad units were created.'
  end
end

if __FILE__ == $0
  begin
    create_ad_units()

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
