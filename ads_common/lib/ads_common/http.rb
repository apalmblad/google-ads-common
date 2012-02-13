# Encoding: utf-8
#
# Authors:: api.dklimkin@gmail.com (Danial Klimkin)
#
# Copyright:: Copyright 2010, Google Inc. All Rights Reserved.
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
# Contains helpful methods to make HTTP requests, using all of the connection
# options available through the client library.

require 'httpi'

require 'ads_common/errors'

module AdsCommon
  module Http
    # HTTP read and open timeouts in seconds.
    HTTP_READ_TIMEOUT = 15 * 60
    HTTP_OPEN_TIMEOUT = 5 * 60

    # Performs a get on a URL, using all of the connection options in the
    # client library, returning a HTTPI::Response.
    def self.get_response(url, config = nil, headers = nil)
      request = prepare_request(url, config, headers)
      response = HTTPI.get(request)
      return response
    end

    # Performs a get on a URL, using all of the connection options in the
    # client library, returning the response body as a string.
    def self.get(url, config = nil, headers = nil)
      return get_response(url, config, headers).body
    end

    # Performs a post on a URL, using all of the connection options in the
    # client library, returning a HTTPI::Response.
    def self.post_response(url, data, config = nil, headers = nil)
      request = prepare_request(url, config, headers, data)
      return HTTPI.post(request)
    end

    # Performs a post on a URL, using all of the connection options in the
    # client library, returning the response body as a string.
    def self.post(url, data, config = nil, headers = nil)
      return post_response(url, data, config, headers).body
    end

    private

    # Returns a suitably configured request object for a given URL and options.
    # Defaulting to stricter :peer validation.
    def self.prepare_request(url, config = nil, headers = nil, data = nil)
      request = HTTPI::Request.new(url)
      request.headers = headers if headers
      request.body = data if data
      configure_httpi(config, request)
      return request
    end

    # Configures HTTPI request according to the config provided.
    def self.configure_httpi(config, httpi)
      if config
        adapter = config.read('connection.adapter')
        HTTPI.adapter = adapter if adapter
        proxy = config.read('connection.proxy')
        httpi.proxy = proxy if proxy
        enable_gzip = config.read('connection.enable_gzip', false)
        httpi.gzip if enable_gzip
        logger = config.read('library.logger')
        if logger
          HTTPI.logger = logger
          HTTPI.log_level = :debug
        end
      end
      httpi.read_timeout = (config.nil?) ? HTTP_READ_TIMEOUT :
          config.read('connection.read_timeout', HTTP_READ_TIMEOUT)
      httpi.open_timeout = (config.nil?) ? HTTP_OPEN_TIMEOUT :
          config.read('connection.open_timeout', HTTP_OPEN_TIMEOUT)
      strict_ssl = config.nil? or
          config.read('connection.strict_ssl_verification', true)
      httpi.auth.ssl.verify_mode = strict_ssl ? :peer : :none
    end
  end
end
