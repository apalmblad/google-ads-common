#!/usr/bin/ruby
# This is auto-generated code, changes will be overwritten.
# Copyright:: Copyright 2011, Google Inc. All Rights Reserved.
# License:: Licensed under the Apache License,Version 2.0 (the "License").
#
# Code generated by AdsCommon library 0.6.1 on 2011-12-20 18:01:52.

require 'dfp_api/errors'

module DfpApi; module V201103; module CompanyService
  class CompanyServiceRegistry
    COMPANYSERVICE_METHODS = {:get_company=>{:output=>{:fields=>[{:type=>"Company", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"get_company_response"}, :input=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:company_id}]}, :update_companies=>{:output=>{:fields=>[{:type=>"Company", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:rval}], :name=>"update_companies_response"}, :input=>[{:type=>"Company", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:companies}]}, :update_company=>{:output=>{:fields=>[{:type=>"Company", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"update_company_response"}, :input=>[{:type=>"Company", :min_occurs=>0, :max_occurs=>1, :name=>:company}]}, :create_companies=>{:output=>{:fields=>[{:type=>"Company", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:rval}], :name=>"create_companies_response"}, :input=>[{:type=>"Company", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:companies}]}, :create_company=>{:output=>{:fields=>[{:type=>"Company", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"create_company_response"}, :input=>[{:type=>"Company", :min_occurs=>0, :max_occurs=>1, :name=>:company}]}, :get_companies_by_statement=>{:output=>{:fields=>[{:type=>"CompanyPage", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"get_companies_by_statement_response"}, :input=>[{:type=>"Statement", :min_occurs=>0, :max_occurs=>1, :name=>:filter_statement}]}}
    COMPANYSERVICE_TYPES = {:Statement=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:query}, {:type=>"String_ValueMapEntry", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:values}]}, :Value=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:value_type}], :abstract=>true}, :PredefinedCustomCriteria=>{:fields=>[{:type=>"long", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:value_ids}], :base=>"CustomCriteria"}, :CompanyPage=>{:fields=>[{:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:total_result_set_size}, {:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:start_index}, {:type=>"Company", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:results}]}, :String_ValueMapEntry=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:key}, {:type=>"Value", :min_occurs=>0, :max_occurs=>1, :name=>:value}]}, :NumberValue=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:value}], :base=>"Value"}, :CustomCriteria=>{:fields=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:key_id}, {:type=>"CustomCriteria.ComparisonOperator", :min_occurs=>0, :max_occurs=>1, :name=>:operator}], :base=>"CustomCriteriaNode"}, :Authentication=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:authentication_type}], :abstract=>true}, :"CustomTargetingValue.MatchType"=>{:fields=>[]}, :"Company.Type"=>{:fields=>[]}, :CustomCriteriaSet=>{:fields=>[{:type=>"CustomCriteriaSet.LogicalOperator", :min_occurs=>0, :max_occurs=>1, :name=>:logical_operator}, {:type=>"CustomCriteriaNode", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:children}], :base=>"CustomCriteriaNode"}, :BooleanValue=>{:fields=>[{:type=>"boolean", :min_occurs=>0, :max_occurs=>1, :name=>:value}], :base=>"Value"}, :"CustomCriteria.ComparisonOperator"=>{:fields=>[]}, :OAuth=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:parameters}], :base=>"Authentication"}, :SoapRequestHeader=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:network_code}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:application_name}, {:type=>"Authentication", :min_occurs=>0, :max_occurs=>1, :name=>:authentication}]}, :CustomCriteriaNode=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:custom_criteria_node_type}], :abstract=>true}, :ClientLogin=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:token}], :base=>"Authentication"}, :"CustomCriteriaSet.LogicalOperator"=>{:fields=>[]}, :TextValue=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:value}], :base=>"Value"}, :SoapResponseHeader=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:request_id}, {:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:response_time}]}, :FreeFormCustomCriteria=>{:fields=>[{:type=>"CustomTargetingValue", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:values}], :base=>"CustomCriteria"}, :CustomTargetingValue=>{:fields=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:custom_targeting_key_id}, {:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:id}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:name}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:display_name}, {:type=>"CustomTargetingValue.MatchType", :min_occurs=>0, :max_occurs=>1, :name=>:match_type}]}, :Company=>{:fields=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:id}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:name}, {:type=>"Company.Type", :min_occurs=>0, :max_occurs=>1, :name=>:type}]}}
    COMPANYSERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return COMPANYSERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return COMPANYSERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return COMPANYSERVICE_NAMESPACES[index]
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
