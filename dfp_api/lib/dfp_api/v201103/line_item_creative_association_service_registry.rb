#!/usr/bin/ruby
# This is auto-generated code, changes will be overwritten.
# Copyright:: Copyright 2011, Google Inc. All Rights Reserved.
# License:: Licensed under the Apache License,Version 2.0 (the "License").
#
# Code generated by AdsCommon library 0.6.1 on 2011-12-20 18:02:31.

require 'dfp_api/errors'

module DfpApi; module V201103; module LineItemCreativeAssociationService
  class LineItemCreativeAssociationServiceRegistry
    LINEITEMCREATIVEASSOCIATIONSERVICE_METHODS = {:get_line_item_creative_association=>{:output=>{:fields=>[{:type=>"LineItemCreativeAssociation", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"get_line_item_creative_association_response"}, :input=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:line_item_id}, {:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:creative_id}]}, :get_line_item_creative_associations_by_statement=>{:output=>{:fields=>[{:type=>"LineItemCreativeAssociationPage", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"get_line_item_creative_associations_by_statement_response"}, :input=>[{:type=>"Statement", :min_occurs=>0, :max_occurs=>1, :name=>:filter_statement}]}, :perform_line_item_creative_association_action=>{:output=>{:fields=>[{:type=>"UpdateResult", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"perform_line_item_creative_association_action_response"}, :input=>[{:type=>"LineItemCreativeAssociationAction", :min_occurs=>0, :max_occurs=>1, :name=>:line_item_creative_association_action}, {:type=>"Statement", :min_occurs=>0, :max_occurs=>1, :name=>:filter_statement}]}, :update_line_item_creative_association=>{:output=>{:fields=>[{:type=>"LineItemCreativeAssociation", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"update_line_item_creative_association_response"}, :input=>[{:type=>"LineItemCreativeAssociation", :min_occurs=>0, :max_occurs=>1, :name=>:line_item_creative_association}]}, :create_line_item_creative_association=>{:output=>{:fields=>[{:type=>"LineItemCreativeAssociation", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"create_line_item_creative_association_response"}, :input=>[{:type=>"LineItemCreativeAssociation", :min_occurs=>0, :max_occurs=>1, :name=>:line_item_creative_association}]}, :update_line_item_creative_associations=>{:output=>{:fields=>[{:type=>"LineItemCreativeAssociation", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:rval}], :name=>"update_line_item_creative_associations_response"}, :input=>[{:type=>"LineItemCreativeAssociation", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:line_item_creative_associations}]}, :create_line_item_creative_associations=>{:output=>{:fields=>[{:type=>"LineItemCreativeAssociation", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:rval}], :name=>"create_line_item_creative_associations_response"}, :input=>[{:type=>"LineItemCreativeAssociation", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:line_item_creative_associations}]}}
    LINEITEMCREATIVEASSOCIATIONSERVICE_TYPES = {:StartDateTimeType=>{:fields=>[]}, :Statement=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:query}, {:type=>"String_ValueMapEntry", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:values}]}, :Money=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:currency_code}, {:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:micro_amount}]}, :LineItemCreativeAssociationStats=>{:fields=>[{:type=>"Stats", :min_occurs=>0, :max_occurs=>1, :name=>:stats}, {:type=>"Money", :min_occurs=>0, :max_occurs=>1, :name=>:cost_in_order_currency}]}, :Value=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:value_type}], :abstract=>true}, :UpdateResult=>{:fields=>[{:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:num_changes}]}, :ActivateLineItemCreativeAssociations=>{:fields=>[], :base=>"LineItemCreativeAssociationAction"}, :String_ValueMapEntry=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:key}, {:type=>"Value", :min_occurs=>0, :max_occurs=>1, :name=>:value}]}, :NumberValue=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:value}], :base=>"Value"}, :DeactivateLineItemCreativeAssociations=>{:fields=>[], :base=>"LineItemCreativeAssociationAction"}, :Authentication=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:authentication_type}], :abstract=>true}, :LineItemCreativeAssociationAction=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:line_item_creative_association_action_type}], :abstract=>true}, :BooleanValue=>{:fields=>[{:type=>"boolean", :min_occurs=>0, :max_occurs=>1, :name=>:value}], :base=>"Value"}, :OAuth=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:parameters}], :base=>"Authentication"}, :Date=>{:fields=>[{:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:year}, {:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:month}, {:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:day}]}, :SoapRequestHeader=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:network_code}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:application_name}, {:type=>"Authentication", :min_occurs=>0, :max_occurs=>1, :name=>:authentication}]}, :LineItemCreativeAssociation=>{:fields=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:line_item_id}, {:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:creative_id}, {:type=>"double", :min_occurs=>0, :max_occurs=>1, :name=>:manual_creative_rotation_weight}, {:type=>"DateTime", :min_occurs=>0, :max_occurs=>1, :name=>:start_date_time}, {:type=>"StartDateTimeType", :min_occurs=>0, :max_occurs=>1, :name=>:start_date_time_type}, {:type=>"DateTime", :min_occurs=>0, :max_occurs=>1, :name=>:end_date_time}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:destination_url}, {:type=>"Size", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:sizes}, {:type=>"LineItemCreativeAssociation.Status", :min_occurs=>0, :max_occurs=>1, :name=>:status}, {:type=>"LineItemCreativeAssociationStats", :min_occurs=>0, :max_occurs=>1, :name=>:stats}]}, :ClientLogin=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:token}], :base=>"Authentication"}, :"LineItemCreativeAssociation.Status"=>{:fields=>[]}, :TextValue=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:value}], :base=>"Value"}, :Size=>{:fields=>[{:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:width}, {:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:height}, {:type=>"boolean", :min_occurs=>0, :max_occurs=>1, :name=>:is_aspect_ratio}]}, :SoapResponseHeader=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:request_id}, {:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:response_time}]}, :LineItemCreativeAssociationPage=>{:fields=>[{:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:total_result_set_size}, {:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:start_index}, {:type=>"LineItemCreativeAssociation", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:results}]}, :DateTime=>{:fields=>[{:type=>"Date", :min_occurs=>0, :max_occurs=>1, :name=>:date}, {:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:hour}, {:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:minute}, {:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:second}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:time_zone_id}]}, :Stats=>{:fields=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:impressions_delivered}, {:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:clicks_delivered}]}}
    LINEITEMCREATIVEASSOCIATIONSERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return LINEITEMCREATIVEASSOCIATIONSERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return LINEITEMCREATIVEASSOCIATIONSERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return LINEITEMCREATIVEASSOCIATIONSERVICE_NAMESPACES[index]
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
