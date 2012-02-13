#!/usr/bin/ruby
# This is auto-generated code, changes will be overwritten.
# Copyright:: Copyright 2011, Google Inc. All Rights Reserved.
# License:: Licensed under the Apache License,Version 2.0 (the "License").
#
# Code generated by AdsCommon library 0.6.0 on 2011-12-02 16:42:48.

require 'adwords_api/errors'

module AdwordsApi; module V201109; module ConversionTrackerService
  class ConversionTrackerServiceRegistry
    CONVERSIONTRACKERSERVICE_METHODS = {:get=>{:input=>[{:name=>:service_selector, :type=>"Selector", :min_occurs=>0, :max_occurs=>1}], :output=>{:name=>"get_response", :fields=>[{:name=>:rval, :type=>"ConversionTrackerPage", :min_occurs=>0, :max_occurs=>1}]}}, :mutate=>{:input=>[{:name=>:operations, :type=>"ConversionTrackerOperation", :min_occurs=>0, :max_occurs=>:unbounded}], :output=>{:name=>"mutate_response", :fields=>[{:name=>:rval, :type=>"ConversionTrackerReturnValue", :min_occurs=>0, :max_occurs=>1}]}}}
    CONVERSIONTRACKERSERVICE_TYPES = {:AdWordsConversionTracker=>{:fields=>[{:name=>:snippet, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:markup_language, :type=>"AdWordsConversionTracker.MarkupLanguage", :min_occurs=>0, :max_occurs=>1}, {:name=>:http_protocol, :type=>"AdWordsConversionTracker.HttpProtocol", :min_occurs=>0, :max_occurs=>1}, {:name=>:text_format, :type=>"AdWordsConversionTracker.TextFormat", :min_occurs=>0, :max_occurs=>1}, {:name=>:conversion_page_language, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:background_color, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:user_revenue_value, :type=>"string", :min_occurs=>0, :max_occurs=>1}], :base=>"ConversionTracker"}, :DateRange=>{:fields=>[{:name=>:min, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:max, :type=>"string", :min_occurs=>0, :max_occurs=>1}]}, :DoubleValue=>{:fields=>[{:name=>:number, :type=>"double", :min_occurs=>0, :max_occurs=>1}], :base=>"NumberValue"}, :LongValue=>{:fields=>[{:name=>:number, :type=>"long", :min_occurs=>0, :max_occurs=>1}], :base=>"NumberValue"}, :Money=>{:fields=>[{:name=>:micro_amount, :type=>"long", :min_occurs=>0, :max_occurs=>1}], :base=>"ComparableValue"}, :NumberValue=>{:fields=>[], :abstract=>true, :base=>"ComparableValue"}, :OrderBy=>{:fields=>[{:name=>:field, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:sort_order, :type=>"SortOrder", :min_occurs=>0, :max_occurs=>1}]}, :Paging=>{:fields=>[{:name=>:start_index, :type=>"int", :min_occurs=>0, :max_occurs=>1}, {:name=>:number_results, :type=>"int", :min_occurs=>0, :max_occurs=>1}]}, :Predicate=>{:fields=>[{:name=>:field, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:operator, :type=>"Predicate.Operator", :min_occurs=>0, :max_occurs=>1}, {:name=>:values, :type=>"string", :min_occurs=>0, :max_occurs=>:unbounded}]}, :SoapHeader=>{:fields=>[{:name=>:auth_token, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:client_customer_id, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:developer_token, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:user_agent, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:validate_only, :type=>"boolean", :min_occurs=>0, :max_occurs=>1}, {:name=>:partial_failure, :type=>"boolean", :min_occurs=>0, :max_occurs=>1}]}, :SoapResponseHeader=>{:fields=>[{:name=>:request_id, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:service_name, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:method_name, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:operations, :type=>"long", :min_occurs=>0, :max_occurs=>1}, {:name=>:response_time, :type=>"long", :min_occurs=>0, :max_occurs=>1}, {:name=>:units, :type=>"long", :min_occurs=>0, :max_occurs=>1}]}, :ComparableValue=>{:fields=>[{:name=>:comparable_value_type, :type=>"string", :min_occurs=>0, :max_occurs=>1}], :abstract=>true}, :ConversionTrackerStats=>{:fields=>[{:name=>:num_conversion_events, :type=>"int", :min_occurs=>0, :max_occurs=>1}, {:name=>:conversion_value, :type=>"Money", :min_occurs=>0, :max_occurs=>1}, {:name=>:most_recent_conversion_date, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:num_converted_clicks, :type=>"int", :min_occurs=>0, :max_occurs=>1}]}, :ConversionTracker=>{:fields=>[{:name=>:id, :type=>"long", :min_occurs=>0, :max_occurs=>1}, {:name=>:name, :type=>"string", :min_occurs=>0, :max_occurs=>1}, {:name=>:status, :type=>"ConversionTracker.Status", :min_occurs=>0, :max_occurs=>1}, {:name=>:category, :type=>"ConversionTracker.Category", :min_occurs=>0, :max_occurs=>1}, {:name=>:stats, :type=>"ConversionTrackerStats", :min_occurs=>0, :max_occurs=>1}, {:name=>:viewthrough_lookback_window, :type=>"int", :min_occurs=>0, :max_occurs=>1}, {:name=>:viewthrough_conversion_de_dup_search, :type=>"boolean", :min_occurs=>0, :max_occurs=>1}, {:name=>:is_product_ads_chargeable, :type=>"boolean", :min_occurs=>0, :max_occurs=>1}, {:name=>:product_ads_chargeable_conversion_window, :type=>"int", :min_occurs=>0, :max_occurs=>1}, {:name=>:conversion_tracker_type, :type=>"string", :min_occurs=>0, :max_occurs=>1}], :abstract=>true}, :ConversionTrackerOperation=>{:fields=>[{:name=>:operand, :type=>"ConversionTracker", :min_occurs=>0, :max_occurs=>1}], :base=>"Operation"}, :ConversionTrackerReturnValue=>{:fields=>[{:name=>:value, :type=>"ConversionTracker", :min_occurs=>0, :max_occurs=>:unbounded}], :base=>"ListReturnValue"}, :ListReturnValue=>{:fields=>[{:name=>:list_return_value_type, :type=>"string", :min_occurs=>0, :max_occurs=>1}], :abstract=>true}, :Operation=>{:fields=>[{:name=>:operator, :type=>"Operator", :min_occurs=>0, :max_occurs=>1}, {:name=>:operation_type, :type=>"string", :min_occurs=>0, :max_occurs=>1}], :abstract=>true}, :Selector=>{:fields=>[{:name=>:fields, :type=>"string", :min_occurs=>0, :max_occurs=>:unbounded}, {:name=>:predicates, :type=>"Predicate", :min_occurs=>0, :max_occurs=>:unbounded}, {:name=>:date_range, :type=>"DateRange", :min_occurs=>0, :max_occurs=>1}, {:name=>:ordering, :type=>"OrderBy", :min_occurs=>0, :max_occurs=>:unbounded}, {:name=>:paging, :type=>"Paging", :min_occurs=>0, :max_occurs=>1}]}, :ConversionTrackerPage=>{:fields=>[{:name=>:entries, :type=>"ConversionTracker", :min_occurs=>0, :max_occurs=>:unbounded}], :base=>"NoStatsPage"}, :NoStatsPage=>{:fields=>[], :abstract=>true, :base=>"Page"}, :Page=>{:fields=>[{:name=>:total_num_entries, :type=>"int", :min_occurs=>0, :max_occurs=>1}, {:name=>:page_type, :type=>"string", :min_occurs=>0, :max_occurs=>1}], :abstract=>true}, :"AdWordsConversionTracker.HttpProtocol"=>{:fields=>[]}, :"AdWordsConversionTracker.MarkupLanguage"=>{:fields=>[]}, :"AdWordsConversionTracker.TextFormat"=>{:fields=>[]}, :"ConversionTracker.Category"=>{:fields=>[]}, :"ConversionTracker.Status"=>{:fields=>[]}, :Operator=>{:fields=>[]}, :"Predicate.Operator"=>{:fields=>[]}, :SortOrder=>{:fields=>[]}}
    CONVERSIONTRACKERSERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return CONVERSIONTRACKERSERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return CONVERSIONTRACKERSERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return CONVERSIONTRACKERSERVICE_NAMESPACES[index]
    end
  end

  # Base class for exceptions.
  class ApplicationException < AdwordsApi::Errors::ApiException
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
