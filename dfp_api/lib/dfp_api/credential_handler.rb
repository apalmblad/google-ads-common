#!/usr/bin/ruby
#
# Authors:: api.dklimkin@gmail.com (Danial Klimkin)
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
# DFP-specific credential handler.

require 'ads_common/credential_handler'
require 'dfp_api/api_config'

module DfpApi
  class CredentialHandler < AdsCommon::CredentialHandler
    # Create the list of credentials to be used by the auth handler for header
    # generation.
    def credentials(version = nil)
      validate_headers_for_server()

      result = case @credentials[:method]
        when :CLIENTLOGIN
          {:email => @credentials[:email],
           :password => @credentials[:password],
           :auth_token => @credentials[:auth_token]}
        when :OAUTH
          {:oauth_consumer_key => @credentials[:oauth_consumer_key],
           :oauth_consumer_secret => @credentials[:oauth_consumer_secret],
           :oauth_verification_code => @credentials[:oauth_verification_code],
           :oauth_token => @credentials[:oauth_token],
           :oauth_token_secret => @credentials[:oauth_token_secret],
           :oauth_callback => @credentials[:oauth_callback],
           :oauth_method => @credentials[:oauth_method],
           :oauth_request_token => @credentials[:oauth_request_token]}
      end
      client_lib = "DfpApi-Ruby-%s" % DfpApi::ApiConfig::CLIENT_LIB_VERSION
      application_name = @credentials[:application_name] || $0
      result[:applicationName] = "%s|%s" % [client_lib, application_name]
      result[:networkCode] = @credentials[:network_code]
      return result.reject {|k, v| v.nil?}
    end

    private

    # Validates that the right credentials are being used for the chosen
    # environment.
    def validate_headers_for_server()
      if @credentials[:application_name].nil?
        raise AdsCommon::Errors::AuthError, 'Application name is not specified'
      end
      return nil
    end
  end
end
