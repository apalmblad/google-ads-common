#!/usr/bin/ruby
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
# This example illustrates how to update a conversion by setting its status to
# 'DISABLED'. To get conversions, run get_all_conversions.rb.
#
# Tags: ConversionTrackerService.mutate

gem 'google-adwords-api'
require 'adwords_api'

API_VERSION = :v201101

def update_conversion()
  # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
  # when called without parameters.
  adwords = AdwordsApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # adwords.logger = Logger.new('adwords_xml.log')

  conv_tracker_srv = adwords.service(:ConversionTrackerService, API_VERSION)

  conversion_id = 'INSERT_CONVERSION_ID_HERE'.to_i

  # Prepare for updating conversion.
  operation = {
    :operator => 'SET',
    :operand => {
      # The 'xsi_type' field allows you to specify the xsi:type of the object
      # being created. It's only necessary when you must provide an explicit
      # type that the client library can't infer.
      :xsi_type => 'AdWordsConversionTracker',
      :id => conversion_id,
      :status => 'DISABLED'
    }
  }

  # Update conversion.
  response = conv_tracker_srv.mutate([operation])
  if response and response[:value]
    conversion = response[:value].first
    puts "Conversion with id #{conversion[:id]}, name " +
        "\"#{conversion[:name]}\", status \"#{conversion[:status]}\" and " +
        " category \"#{conversion[:category]}\" was disabled."
  else
    puts 'No conversions were updated.'
  end
end

if __FILE__ == $0
  begin
    update_conversion()

  # Connection error. Likely transitory.
  rescue Errno::ECONNRESET, SOAP::HTTPStreamError, SocketError => e
    puts 'Connection Error: %s' % e
    puts 'Source: %s' % e.backtrace.first

  # API Error.
  rescue AdwordsApi::Errors::ApiException => e
    puts 'API Exception caught.'
    puts 'Message: %s' % e.message
    puts 'Code: %d' % e.code if e.code
    puts 'Trigger: %s' % e.trigger if e.trigger
    puts 'Errors:'
    if e.errors
      e.errors.each_with_index do |error, index|
        puts ' %d. Error type is %s. Fields:' % [index + 1, error[:xsi_type]]
        error.each_pair do |field, value|
          if field != :xsi_type
            puts '     %s: %s' % [field, value]
          end
        end
      end
    end
  end
end
