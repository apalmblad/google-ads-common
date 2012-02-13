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
# This example updates the descriptions of all labels that are competitive
# exclusion by updating its description up to the first 500. To determine which
# labels exist, run get_all_labels.rb.
#
# This feature is only available to DFP premium solution networks.
#
# Tags: LabelService.getLabelsByStatement, LabelService.updateLabels

require 'dfp_api'

API_VERSION = :v201201

def update_labels()
  # Get DfpApi instance and load configuration from ~/dfp_api.yml.
  dfp = DfpApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # dfp.logger = Logger.new('dfp_xml.log')

  # Get the LabelService.
  label_service = dfp.service(:LabelService, API_VERSION)

  # Create a statement to only select labels that are competitive exclusion and
  # active.
  statement = {
      :query => 'WHERE type = :type and isActive = true LIMIT 500',
      :values => [
          {:key => 'type',
           :value => {
               :value => 'COMPETITIVE_EXCLUSION',
               :xsi_type => 'TextValue'}
          }
      ]
  }

  # Get labels by statement.
  page = label_service.get_labels_by_statement(statement)

  if page[:results]
    labels = page[:results]

    # Update each local label object by changing its description.
    labels.each do |label|
      label[:description] =
          'These labels are still competiting with each other'
    end

    # Update the labels on the server.
    return_labels = label_service.update_labels(labels)

    if return_labels
      return_labels.each do |label|
        puts ("Label ID: %d, name: %s was updated with description: %s.") %
            [label[:id], label[:name], label[:description]]
      end
    else
      raise 'No labels were updated.'
    end
  else
    puts 'No labels found to update.'
  end
end

if __FILE__ == $0
  begin
    update_labels()

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
