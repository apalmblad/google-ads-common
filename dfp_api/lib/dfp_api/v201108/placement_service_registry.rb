#!/usr/bin/ruby
# This is auto-generated code, changes will be overwritten.
# Copyright:: Copyright 2011, Google Inc. All Rights Reserved.
# License:: Licensed under the Apache License,Version 2.0 (the "License").
#
# Code generated by AdsCommon library 0.6.1 on 2011-12-20 18:03:26.

require 'dfp_api/errors'

module DfpApi; module V201108; module PlacementService
  class PlacementServiceRegistry
    PLACEMENTSERVICE_METHODS = {:perform_placement_action=>{:output=>{:fields=>[{:type=>"UpdateResult", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"perform_placement_action_response"}, :input=>[{:type=>"PlacementAction", :min_occurs=>0, :max_occurs=>1, :name=>:placement_action}, {:type=>"Statement", :min_occurs=>0, :max_occurs=>1, :name=>:filter_statement}]}, :update_placement=>{:output=>{:fields=>[{:type=>"Placement", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"update_placement_response"}, :input=>[{:type=>"Placement", :min_occurs=>0, :max_occurs=>1, :name=>:placement}]}, :create_placement=>{:output=>{:fields=>[{:type=>"Placement", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"create_placement_response"}, :input=>[{:type=>"Placement", :min_occurs=>0, :max_occurs=>1, :name=>:placement}]}, :update_placements=>{:output=>{:fields=>[{:type=>"Placement", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:rval}], :name=>"update_placements_response"}, :input=>[{:type=>"Placement", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:placements}]}, :create_placements=>{:output=>{:fields=>[{:type=>"Placement", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:rval}], :name=>"create_placements_response"}, :input=>[{:type=>"Placement", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:placements}]}, :get_placement=>{:output=>{:fields=>[{:type=>"Placement", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"get_placement_response"}, :input=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:placement_id}]}, :get_placements_by_statement=>{:output=>{:fields=>[{:type=>"PlacementPage", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"get_placements_by_statement_response"}, :input=>[{:type=>"Statement", :min_occurs=>0, :max_occurs=>1, :name=>:filter_statement}]}}
    PLACEMENTSERVICE_TYPES = {:Statement=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:query}, {:type=>"String_ValueMapEntry", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:values}]}, :ArchivePlacements=>{:fields=>[], :base=>"PlacementAction"}, :Value=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:value_type}], :abstract=>true}, :UpdateResult=>{:fields=>[{:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:num_changes}]}, :String_ValueMapEntry=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:key}, {:type=>"Value", :min_occurs=>0, :max_occurs=>1, :name=>:value}]}, :NumberValue=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:value}], :base=>"Value"}, :DeactivatePlacements=>{:fields=>[], :base=>"PlacementAction"}, :AdUnitSize=>{:fields=>[{:type=>"Size", :min_occurs=>0, :max_occurs=>1, :name=>:size}, {:type=>"EnvironmentType", :min_occurs=>0, :max_occurs=>1, :name=>:environment_type}, {:type=>"AdUnitSize", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:companions}]}, :Authentication=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:authentication_type}], :abstract=>true}, :PlacementAction=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:placement_action_type}], :abstract=>true}, :BooleanValue=>{:fields=>[{:type=>"boolean", :min_occurs=>0, :max_occurs=>1, :name=>:value}], :base=>"Value"}, :Placement=>{:fields=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:id}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:name}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:description}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:placement_code}, {:type=>"InventoryStatus", :min_occurs=>0, :max_occurs=>1, :name=>:status}, {:type=>"boolean", :min_occurs=>0, :max_occurs=>1, :name=>:is_ad_sense_targeting_enabled}, {:type=>"boolean", :min_occurs=>0, :max_occurs=>1, :name=>:is_ad_planner_targeting_enabled}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:ad_sense_targeting_locale}, {:type=>"string", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:targeted_ad_unit_ids}], :base=>"SiteTargetingInfo"}, :OAuth=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:parameters}], :base=>"Authentication"}, :SoapRequestHeader=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:network_code}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:application_name}, {:type=>"Authentication", :min_occurs=>0, :max_occurs=>1, :name=>:authentication}]}, :ClientLogin=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:token}], :base=>"Authentication"}, :InventoryStatus=>{:fields=>[]}, :TextValue=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:value}], :base=>"Value"}, :Size=>{:fields=>[{:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:width}, {:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:height}, {:type=>"boolean", :min_occurs=>0, :max_occurs=>1, :name=>:is_aspect_ratio}]}, :PlacementPage=>{:fields=>[{:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:total_result_set_size}, {:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:start_index}, {:type=>"Placement", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:results}]}, :EnvironmentType=>{:fields=>[]}, :SoapResponseHeader=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:request_id}, {:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:response_time}]}, :ActivatePlacements=>{:fields=>[], :base=>"PlacementAction"}, :SiteTargetingInfo=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:targeting_description}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:targeting_site_name}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:targeting_ad_location}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:site_targeting_info_type}]}}
    PLACEMENTSERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return PLACEMENTSERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return PLACEMENTSERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return PLACEMENTSERVICE_NAMESPACES[index]
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
