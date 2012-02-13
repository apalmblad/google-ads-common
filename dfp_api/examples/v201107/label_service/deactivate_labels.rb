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
# This example deactivates all active labels. To determine which labels exist,
# run get_all_labels.rb.
#
# This feature is only available to DFP premium solution networks.
#
# Tags: LabelService.getLabelsByStatement, LabelService.performLabelAction

require 'dfp_api'

API_VERSION = :v201107
PAGE_SIZE = 500

def deactivate_labels()
  # Get DfpApi instance and load configuration from ~/dfp_api.yml.
  dfp = DfpApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # dfp.logger = Logger.new('dfp_xml.log')

  # Get the LabelService.
  label_service = dfp.service(:LabelService, API_VERSION)

  # Create statement text and statement to select active labels.
  statement_text = 'WHERE isActive = :is_active'
  statement = {
      :values => [
          {:key => 'is_active',
           :value => {:value => true, :xsi_type => 'BooleanValue'}}
      ]
  }

  # Define initial values.
  offset = 0
  page = {}
  label_ids = []

  begin
    # Modify the statement to get one page with current offset.
    statement[:query] = statement_text +
        " LIMIT %d OFFSET %d" % [PAGE_SIZE, offset]

    # Get labels by statement.
    page = label_service.get_labels_by_statement(statement)

    if page[:results]
      # Increase query offset by page size.
      offset += PAGE_SIZE

      page[:results].each do |label|
        puts ("%d) Label ID: %d, name: %s will be deactivated.") %
            [label_ids.size, label[:id], label[:name]]
        label_ids << label[:id]
      end
    end
  end while offset < page[:total_result_set_size]

  puts "Number of labels to be deactivated: %d" % label_ids.size

  if !label_ids.empty?
    # Create a statement for action.
    statement = {:query => "WHERE id IN (%s)" % label_ids.join(', ')}

    # Perform action.
    result = label_service.perform_label_action(
        {:xsi_type => 'DeactivateLabels'}, statement)

    # Display results.
    if result and result[:num_changes] > 0
      puts "Number of labels deactivated: %d" % result[:num_changes]
    else
      puts 'No labels were deactivated.'
    end
  else
    puts 'No labels found to deactivate.'
  end
end

if __FILE__ == $0
  begin
    deactivate_labels()

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
