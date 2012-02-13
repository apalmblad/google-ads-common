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
# This example illustrates how to create a text ad with ad parameters. To add an
# ad group, run add_ad_group.rb. To add a keyword, run add_keywords.rb.
#
# Tags: AdGroupAdService.mutate, AdParamService.mutate

require 'adwords_api'

API_VERSION = :v201109

def set_ad_parameters()
  # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
  # when called without parameters.
  adwords = AdwordsApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # adwords.logger = Logger.new('adwords_xml.log')

  ad_group_ad_srv = adwords.service(:AdGroupAdService, API_VERSION)
  ad_param_srv = adwords.service(:AdParamService, API_VERSION)

  ad_group_id = 'INSERT_AD_GROUP_ID_HERE'.to_i
  criterion_id = 'INSERT_CRITERION_ID_HERE'.to_i

  # Prepare for adding ad.
  ad_operation = {
    :operator => 'ADD',
    :operand => {
      :ad_group_id => ad_group_id,
      :ad => {
        # The 'xsi_type' field allows you to specify the xsi:type of the object
        # being created. It's only necessary when you must provide an explicit
        # type that the client library can't infer.
        :xsi_type => 'TextAd',
        :headline => 'Luxury Mars Cruises',
        :description1 => 'Low-gravity fun for {param1:cheap}.',
        :description2 => 'Only {param2:a few} seats left!',
        :url => 'http://www.example.com',
        :display_url => 'www.example.com'
      }
    }
  }

  # Add ad.
  response = ad_group_ad_srv.mutate([ad_operation])
  ad = response[:value].first[:ad]
  puts 'Text ad id %d was successfully added.' % ad[:id]

  # Prepare for setting ad parameters.
  price_operation = {
    :operator => 'SET',
    :operand => {
      :ad_group_id => ad_group_id,
      :criterion_id => criterion_id,
      :param_index => 1,
      :insertion_text => '$100'
    }
  }

  seat_operation = {
    :operator => 'SET',
    :operand => {
      :ad_group_id => ad_group_id,
      :criterion_id => criterion_id,
      :param_index => 2,
      :insertion_text => '50'
    }
  }

  # Set ad parameters.
  response = ad_param_srv.mutate([price_operation, seat_operation])
  puts 'Parameters were successfully updated.'
end

if __FILE__ == $0
  begin
    set_ad_parameters()

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
