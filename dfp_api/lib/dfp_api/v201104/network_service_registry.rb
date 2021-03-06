#!/usr/bin/ruby
# This is auto-generated code, changes will be overwritten.
# Copyright:: Copyright 2011, Google Inc. All Rights Reserved.
# License:: Licensed under the Apache License,Version 2.0 (the "License").
#
# Code generated by AdsCommon library 0.6.1 on 2011-12-20 17:59:05.

require 'dfp_api/errors'

module DfpApi; module V201104; module NetworkService
  class NetworkServiceRegistry
    NETWORKSERVICE_METHODS = {:get_all_networks=>{:output=>{:fields=>[{:type=>"Network", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:rval}], :name=>"get_all_networks_response"}, :input=>[]}, :get_current_network=>{:output=>{:fields=>[{:type=>"Network", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"get_current_network_response"}, :input=>[]}, :update_network=>{:output=>{:fields=>[{:type=>"Network", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"update_network_response"}, :input=>[{:type=>"Network", :min_occurs=>0, :max_occurs=>1, :name=>:network}]}}
    NETWORKSERVICE_TYPES = {:Authentication=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:authentication_type}], :abstract=>true}, :OAuth=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:parameters}], :base=>"Authentication"}, :Network=>{:fields=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:id}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:display_name}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:network_code}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:property_code}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:time_zone}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:currency_code}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:effective_root_ad_unit_id}]}, :SoapRequestHeader=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:network_code}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:application_name}, {:type=>"Authentication", :min_occurs=>0, :max_occurs=>1, :name=>:authentication}]}, :ClientLogin=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:token}], :base=>"Authentication"}, :SoapResponseHeader=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:request_id}, {:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:response_time}]}}
    NETWORKSERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return NETWORKSERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return NETWORKSERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return NETWORKSERVICE_NAMESPACES[index]
    end
  end

  # Base class for exceptions.
  class ApplicationException < DfpApi::Errors::ApiException
    attr_reader :message  # string
    attr_reader :application_exception_type  # string
  end

  # Exception class for holding a list of service errors.
  class ApiException < ApplicationException
    attr_reader :errors  # ApiError
    def initialize(exception_fault)
      @array_fields ||= []
      @array_fields << 'errors'
      super(exception_fault)
    end
  end
end; end; end
