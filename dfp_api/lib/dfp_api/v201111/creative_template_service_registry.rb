#!/usr/bin/ruby
# This is auto-generated code, changes will be overwritten.
# Copyright:: Copyright 2011, Google Inc. All Rights Reserved.
# License:: Licensed under the Apache License,Version 2.0 (the "License").
#
# Code generated by AdsCommon library 0.6.1 on 2011-12-20 18:00:23.

require 'dfp_api/errors'

module DfpApi; module V201111; module CreativeTemplateService
  class CreativeTemplateServiceRegistry
    CREATIVETEMPLATESERVICE_METHODS = {:get_creative_template=>{:output=>{:fields=>[{:type=>"CreativeTemplate", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"get_creative_template_response"}, :input=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:creative_template_id}]}, :get_creative_templates_by_statement=>{:output=>{:fields=>[{:type=>"CreativeTemplatePage", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"get_creative_templates_by_statement_response"}, :input=>[{:type=>"Statement", :min_occurs=>0, :max_occurs=>1, :name=>:filter_statement}]}}
    CREATIVETEMPLATESERVICE_TYPES = {:Statement=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:query}, {:type=>"String_ValueMapEntry", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:values}]}, :Value=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:value_type}], :abstract=>true}, :LongCreativeTemplateVariable=>{:fields=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:default_value}], :base=>"CreativeTemplateVariable"}, :CreativeTemplateStatus=>{:fields=>[]}, :String_ValueMapEntry=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:key}, {:type=>"Value", :min_occurs=>0, :max_occurs=>1, :name=>:value}]}, :NumberValue=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:value}], :base=>"Value"}, :CreativeTemplatePage=>{:fields=>[{:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:total_result_set_size}, {:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:start_index}, {:type=>"CreativeTemplate", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:results}]}, :Authentication=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:authentication_type}], :abstract=>true}, :CreativeTemplateType=>{:fields=>[]}, :AssetCreativeTemplateVariable=>{:fields=>[{:type=>"AssetCreativeTemplateVariable.MimeType", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:mime_types}], :base=>"CreativeTemplateVariable"}, :StringCreativeTemplateVariable=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:default_value}], :base=>"CreativeTemplateVariable"}, :"ListStringCreativeTemplateVariable.VariableChoice"=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:label}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:value}]}, :BooleanValue=>{:fields=>[{:type=>"boolean", :min_occurs=>0, :max_occurs=>1, :name=>:value}], :base=>"Value"}, :"AssetCreativeTemplateVariable.MimeType"=>{:fields=>[]}, :OAuth=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:parameters}], :base=>"Authentication"}, :CreativeTemplate=>{:fields=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:id}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:name}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:description}, {:type=>"CreativeTemplateVariable", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:variables}, {:type=>"CreativeTemplateStatus", :min_occurs=>0, :max_occurs=>1, :name=>:status}, {:type=>"CreativeTemplateType", :min_occurs=>0, :max_occurs=>1, :name=>:type}, {:type=>"boolean", :min_occurs=>0, :max_occurs=>1, :name=>:is_interstitial}]}, :SoapRequestHeader=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:network_code}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:application_name}, {:type=>"Authentication", :min_occurs=>0, :max_occurs=>1, :name=>:authentication}]}, :UrlCreativeTemplateVariable=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:default_value}], :base=>"CreativeTemplateVariable"}, :ClientLogin=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:token}], :base=>"Authentication"}, :TextValue=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:value}], :base=>"Value"}, :ListStringCreativeTemplateVariable=>{:fields=>[{:type=>"ListStringCreativeTemplateVariable.VariableChoice", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:choices}, {:type=>"boolean", :min_occurs=>0, :max_occurs=>1, :name=>:allow_other_choice}], :base=>"StringCreativeTemplateVariable"}, :SoapResponseHeader=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:request_id}, {:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:response_time}]}, :CreativeTemplateVariable=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:label}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:unique_name}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:description}, {:type=>"boolean", :min_occurs=>0, :max_occurs=>1, :name=>:is_required}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:creative_template_variable_type}], :abstract=>true}}
    CREATIVETEMPLATESERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return CREATIVETEMPLATESERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return CREATIVETEMPLATESERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return CREATIVETEMPLATESERVICE_NAMESPACES[index]
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
