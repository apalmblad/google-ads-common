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
# This example illustrates how to update an ad, setting its status to 'PAUSED'.
# To create ads, run add_text_ads.rb.
#
# Tags: AdGroupAdService.mutate

require 'adwords_api'

API_VERSION = :v201109

def pause_ad()
  # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
  # when called without parameters.
  adwords = AdwordsApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # adwords.logger = Logger.new('adwords_xml.log')

  ad_group_ad_srv = adwords.service(:AdGroupAdService, API_VERSION)

  ad_group_id = 'INSERT_AD_GROUP_ID_HERE'.to_i
  ad_id = 'INSERT_AD_ID_HERE'.to_i

  # Prepare operation for updating ad.
  operation = {
    :operator => 'SET',
    :operand => {
      :ad_group_id => ad_group_id,
      :status => 'PAUSED',
      :ad => {:id => ad_id}
    }
  }

  # Update ad.
  response = ad_group_ad_srv.mutate([operation])
  if response and response[:value]
    ad = response[:value].first
    puts "Ad ID %d was successfully updated, status set to '%s'." %
        [ad[:ad][:id], ad[:status]]
  else
    puts 'No ads were updated.'
  end
end

if __FILE__ == $0
  begin
    pause_ad()

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
