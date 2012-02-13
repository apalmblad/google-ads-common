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
# This example creates new custom targeting keys and values. To determine which
# custom targeting keys and values exist, run
# get_all_custom_targeting_keys_and_values.rb. To target these custom targeting
# keys and values, run target_custom_criteria.rb.
#
# Tags: CustomTargetingService.createCustomTargetingKeys,
#       CustomTargetingService.createCustomTargetingValues

require 'dfp_api'

API_VERSION = :v201103

def create_custom_targeting_keys_and_values()
  # Get DfpApi instance and load configuration from ~/dfp_api.yml.
  dfp = DfpApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # dfp.logger = Logger.new('dfp_xml.log')

  # Get the CustomTargetingService.
  custom_targeting_service = dfp.service(:CustomTargetingService, API_VERSION)

  # Create predefined key.
  gender_key = {:display_name => 'gender', :name => 'g', :type => 'PREDEFINED'}

  # Create free-form key.
  car_model_key = {:display_name => 'car model', :name => 'c',
      :type => 'FREEFORM'}

  # Create the custom targeting keys on the server.
  return_keys = custom_targeting_service.create_custom_targeting_keys(
      [gender_key, car_model_key])

  if return_keys
    return_keys.each do |key|
      puts ("Custom targeting key ID: %d, name: %s and display name: %s" +
            " was created.") % [key[:id], key[:name], key[:display_name]]
    end
  else
    raise 'No keys were created.'
  end

  # Create custom targeting value for the predefined gender key.
  gender_male_value = {:custom_targeting_key_id => return_keys[0][:id],
      :display_name => 'male', :match_type => 'EXACT'}
  # Name is set to 1 so that the actual name can be hidden from website users.
  gender_male_value[:name] = '1'

  # Create another custom targeting value for the same key.
  gender_female_value = {:custom_targeting_key_id => return_keys[0][:id],
      :display_name => 'female', :name => '2', :match_type => 'EXACT'}

  # Create custom targeting value for the free-form age key. These are values
  # that would be suggested in the UI or can be used when targeting
  # with a free-form custom criterion.
  car_model_honda_civic_value = {
      :custom_targeting_key_id => return_keys[1][:id],
      :display_name => 'honda civic', :name => 'honda civic'}
  # Setting match type to exact will match exactly "honda civic".
  car_model_honda_civic_value[:match_type] = 'EXACT'

  # Create the custom targeting values on the server.
  return_values = custom_targeting_service.create_custom_targeting_values(
      [gender_male_value, gender_female_value, car_model_honda_civic_value])

  if return_values
    return_values.each do |value|
      puts ("A custom targeting value ID: %d, name: %s and display name: %s" +
          " was created for key ID: %d.") % [value[:id], value[:name],
          value[:display_name], value[:custom_targeting_key_id]]
    end
  else
    raise 'No values were created.'
  end

end

if __FILE__ == $0
  begin
    create_custom_targeting_keys_and_values()

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
