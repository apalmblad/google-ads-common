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
# This example gets up to 500 system defined creative templates.
#
# Tags: CreativeTemplateService.getCreativeTemplatesByStatement

require 'dfp_api'

API_VERSION = :v201111

def get_creative_templates_by_statement()
  # Get DfpApi instance and load configuration from ~/dfp_api.yml.
  dfp = DfpApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # dfp.logger = Logger.new('dfp_xml.log')

  # Get the CreativeTemplateService.
  creative_template_service = dfp.service(:CreativeTemplateService, API_VERSION)

  # Create a statement to only select image creative_templates.
  statement = {:query => 'LIMIT 500'}

  # Get creative templates by statement.
  page =
      creative_template_service.get_creative_templates_by_statement(statement)

  if page[:results]
    # Print details about each creative template in results.
    page[:results].each_with_index do |template, index|
      puts "%d) Creative template ID: %d, name: %s, type: %s" %
          [index, template[:id], template[:name], template[:type]]
    end
  end

  # Print a footer.
  if page.include?(:total_result_set_size)
    puts "Total number of creative templates: %d" % page[:total_result_set_size]
  end
end

if __FILE__ == $0
  begin
    get_creative_templates_by_statement()

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
