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
# This example creates new line item creative associations (LICAs) for an
# existing line item and a set of creative ids. For small business networks,
# the creative ids must represent new or copied creatives as creatives cannot
# be used for more than one line item. For premium solution networks, the
# creative ids can represent any creatvie. To copy creatives, run
# copy_image_creatives.rb. To determine which LICAs exist, run get_all_licas.rb.
#
# Tags: LineItemCreativeAssociationService.createLineItemCreativeAssociations

require 'dfp_api'

API_VERSION = :v201104

def create_licas()
  # Get DfpApi instance and load configuration from ~/dfp_api.yml.
  dfp = DfpApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # dfp.logger = Logger.new('dfp_xml.log')

  # Get the LineItemCreativeAssociationService.
  lica_service = dfp.service(:LineItemCreativeAssociationService, API_VERSION)

  # Get the CreativeService.
  creative_service = dfp.service(:CreativeService, API_VERSION)

  # Set the line item ID and creative IDs to associate.
  line_item_id = 'INSERT_LINE_ITEM_ID_HERE'.to_i
  creative_ids = [
      'INSERT_CREATIVE_ID_HERE'.to_i,
      'INSERT_CREATIVE_ID_HERE'.to_i
  ]

  # Create an array to store local LICA objects.
  licas = creative_ids.map do |creative_id|
    # For each line item, associate it with the given creative.
    {:line_item_id => line_item_id, :creative_id => creative_id}
  end

  # Create the LICAs on the server.
  return_licas = lica_service.create_line_item_creative_associations(licas)

  if return_licas
    return_licas.each do |lica|
      puts ("LICA with line item ID: %d, creative ID: %d and status: %s was " +
          "created.") % [lica[:line_item_id], lica[:creative_id], lica[:status]]
    end
  else
    raise 'No LICAs were created.'
  end

end

if __FILE__ == $0
  begin
    create_licas()

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
