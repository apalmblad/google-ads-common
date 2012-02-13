#!/usr/bin/env ruby
# Encoding: utf-8
#
# Author:: api.sgomes@gmail.com (Sérgio Gomes)
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
# This example illustrates how to create a campaign.
#
# Tags: CampaignService.mutate

require 'adwords_api'

API_VERSION = :v201109

def add_campaign()
  # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
  # when called without parameters.
  adwords = AdwordsApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # adwords.logger = Logger.new('adwords_xml.log')

  campaign_srv = adwords.service(:CampaignService, API_VERSION)

  # Prepare for adding campaign.
  operation = {
    :operator => 'ADD',
    :operand => {
      :name => "Interplanetary Cruise #%d" % (Time.new.to_f * 1000).to_i,
      :status => 'PAUSED',
      :bidding_strategy => {
        # The 'xsi_type' field allows you to specify the xsi:type of the object
        # being created. It's only necessary when you must provide an explicit
        # type that the client library can't infer.
        :xsi_type => 'ManualCPC'
      },
      :budget => {
        :period => 'DAILY',
        :amount => {
          :micro_amount => 50000000
        },
        :delivery_method => 'STANDARD'
      },
      # Set the campaign network options to Search and Search Network.
      :network_setting => {
        :target_google_search => true,
        :target_search_network => true,
        :target_content_network => false,
        :target_content_contextual => false
      }
    }
  }

  # Add campaign.
  response = campaign_srv.mutate([operation])
  if response and response[:value]
    campaign = response[:value].first
    puts "Campaign with name '%s' and ID %d was added." %
        [campaign[:name], campaign[:id]]
  else
    puts 'No campaigns were added.'
  end
end

if __FILE__ == $0
  begin
    add_campaign()

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
