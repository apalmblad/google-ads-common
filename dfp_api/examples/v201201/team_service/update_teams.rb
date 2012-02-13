#!/usr/bin/env ruby
#
# Author:: api.dklimkin@gmail.com (Danial Klimkin)
#
# Copyright:: Copyright 2012, Google Inc. All Rights Reserved.
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
# This example updates teams by adding you to them up to the first 500. To
# determine which teams exist, run get_all_teams.rb.
#
# Tags: TeamService.getTeamsByStatement, TeamService.updateTeams
# Tags: UserService.getCurrentUser

require 'dfp_api'

API_VERSION = :v201201

def update_teams()
  # Get DfpApi instance and load configuration from ~/dfp_api.yml.
  dfp = DfpApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # dfp.logger = Logger.new('dfp_xml.log')

  # Get the TeamService.
  team_service = dfp.service(:TeamService, API_VERSION)

  # Get the UserService.
  user_service = dfp.service(:UserService, API_VERSION)

  # Get the current user's ID.
  current_user = user_service.get_current_user()
  user_id = current_user[:id]

  # Create a statement to select first 500 teams.
  statement = {:query => 'LIMIT 500'}

  # Get teams by statement.
  page = team_service.get_teams_by_statement(statement)

  if page[:results]
    teams = page[:results]

    # Create a local set of teams than need to be updated. We are updating by
    # adding the current user to it, if it is not already there.
    updated_teams = teams.inject([]) do |updated_teams, team|
      unless team[:user_ids].nil? or team[:user_ids].include?(user_id)
        team[:user_ids] << user_id
        updated_teams << team
        puts "Adding user ID %d into team ID %d" % [user_id, team[:id]]
      end
      updated_teams
    end

    # Update the teams on the server.
    return_teams = team_service.update_teams(updated_teams)

    if return_teams
      return_teams.each do |team|
        puts ("Team ID: %d was updated with user ids: [%s]") %
            [team[:id], team[:user_ids].join(', ')]
      end
    else
      raise 'No teams were updated.'
    end
  else
    puts 'No teams found to update.'
  end
end

if __FILE__ == $0
  begin
    update_teams()

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
