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
# This example gets and downloads an Ad Hoc report from a XML report definition.

require 'adwords_api'

API_VERSION = :v201109

def download_adhoc_report()
  # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
  # when called without parameters.
  adwords = AdwordsApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # adwords.logger = Logger.new('adwords_xml.log')

  # Get report utilities for the version.
  report_utils = adwords.report_utils(API_VERSION)

  # File name to write report to. To retrieve the report as return value, use
  # "download_report" method.
  file_name = 'INSERT_OUTPUT_FILE_NAME_HERE'

  # Define report definition. You can also pass your own XML text as a string.
  report_definition = {
    :selector => {
        :fields => ['CampaignId', 'Id', 'Impressions', 'Clicks', 'Cost'],
        # Predicates are optional.
        :predicates => {
          :field => 'Status',
          :operator => 'IN',
          :values => ['ENABLED', 'PAUSED']
        }
      },
      :report_name => 'Custom ADGROUP_PERFORMANCE_REPORT',
      :report_type => 'ADGROUP_PERFORMANCE_REPORT',
      :download_format => 'CSV',
      :date_range_type => 'LAST_7_DAYS',
      # Enable to get rows with zero impressions.
      :include_zero_impressions => false
  }

  # Download report, using "download_report_as_file" utility method.
  report_utils.download_report_as_file(report_definition, file_name)
  puts "Report was downloaded to '%s'." % file_name
end

if __FILE__ == $0
  begin
    download_adhoc_report()

  # HTTP errors.
  rescue AdsCommon::Errors::HttpError => e
    puts "HTTP Error: %s" % e

  # API errors.
  rescue AdwordsApi::Errors::ReportError => e
    puts "Reporting Error: %s" % e.message
  end
end
