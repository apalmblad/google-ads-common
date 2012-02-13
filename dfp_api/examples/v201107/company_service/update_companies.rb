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
# This example updates the names of all companies that are advertisers by
# appending "LLC." up to the first 500. To determine which companies exist, run
# get_all_companies.rb.
#
# Tags: CompanyService.getCompaniesByStatement, CompanyService.updateCompanies

require 'dfp_api'

API_VERSION = :v201107

def update_companies()
  # Get DfpApi instance and load configuration from ~/dfp_api.yml.
  dfp = DfpApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # dfp.logger = Logger.new('dfp_xml.log')

  # Get the CompanyService.
  company_service = dfp.service(:CompanyService, API_VERSION)

  # Create a statement to only select companies that are advertisers.
  statement = {
      :query => "WHERE type = :type LIMIT 500",
      :values => [
          {:key => 'type',
           :value => {:value => 'ADVERTISER', :xsi_type => 'TextValue'}}
      ]
  }

  # Get companies by statement.
  page = company_service.get_companies_by_statement(statement)

  if page[:results]
    companies = page[:results]

    # Update each local company object by appending ' LLC.' to its name.
    companies.each {|company| company[:name] += ' LLC.'}

    # Update the companies on the server.
    return_companies = company_service.update_companies(companies)

    if return_companies
      return_companies.each do |company|
        puts "A company with ID [%d], name: %s and type %s was updated." %
            [company[:id], company[:name], company[:type]]
      end
    else
      raise 'No companies were updated.'
    end
  else
    puts 'No companies found to update.'
  end
end

if __FILE__ == $0
  begin
    update_companies()

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
