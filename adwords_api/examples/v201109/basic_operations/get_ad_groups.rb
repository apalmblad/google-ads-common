#!/usr/bin/env ruby
# Encoding: utf-8
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
# This example illustrates how to retrieve all the ad groups for a campaign. To
# create an ad group, run add_ad_group.rb.
#
# Tags: AdGroupService.get

require 'adwords_api'

API_VERSION = :v201109
PAGE_SIZE = 500

def get_ad_groups()
  # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
  # when called without parameters.
  adwords = AdwordsApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # adwords.logger = Logger.new('adwords_xml.log')

  ad_group_srv = adwords.service(:AdGroupService, API_VERSION)

  campaign_id = 'INSERT_CAMPAIGN_ID_HERE'.to_i

  # Get all the ad groups for this campaign.
  selector = {
    :fields => ['Id', 'Name'],
    :ordering => [{:field => 'Name', :sort_order => 'ASCENDING'}],
    :predicates => [
      {:field => 'CampaignId', :operator => 'IN', :values => [campaign_id]}
    ],
    :paging => {
      :start_index => 0,
      :number_results => PAGE_SIZE
    }
  }

  # Set initial values.
  offset, page = 0, {}

  begin
    page = ad_group_srv.get(selector)
    if page[:entries]
      page[:entries].each do |ad_group|
        puts "Ad group name is '%s' and ID is %d" %
            [ad_group[:name], ad_group[:id]]
      end
      # Increment values to request the next page.
      offset += PAGE_SIZE
      selector[:paging][:start_index] = offset
    end
  end while page[:total_num_entries] > offset

  if page.include?(:total_num_entries)
    puts "\tCampaign ID %d has %d ad group(s)." %
        [campaign_id, page[:total_num_entries]]
  end
end

if __FILE__ == $0
  begin
    get_ad_groups()

  # HTTP errors.
  rescue AdsCommon::Errors::HttpError => e
    puts "HTTP Error: %s" % e

  # API errors.
  rescue AdwordsApi::Errors::ApiException => e
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
