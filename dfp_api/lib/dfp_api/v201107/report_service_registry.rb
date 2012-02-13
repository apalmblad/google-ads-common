#!/usr/bin/ruby
# This is auto-generated code, changes will be overwritten.
# Copyright:: Copyright 2011, Google Inc. All Rights Reserved.
# License:: Licensed under the Apache License,Version 2.0 (the "License").
#
# Code generated by AdsCommon library 0.6.1 on 2011-12-20 18:00:51.

require 'dfp_api/errors'

module DfpApi; module V201107; module ReportService
  class ReportServiceRegistry
    REPORTSERVICE_METHODS = {:get_report_download_url=>{:output=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"get_report_download_url_response"}, :original_name=>"getReportDownloadURL", :input=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:report_job_id}, {:type=>"ExportFormat", :min_occurs=>0, :max_occurs=>1, :name=>:export_format}]}, :get_report_job=>{:output=>{:fields=>[{:type=>"ReportJob", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"get_report_job_response"}, :input=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:report_job_id}]}, :run_report_job=>{:output=>{:fields=>[{:type=>"ReportJob", :min_occurs=>0, :max_occurs=>1, :name=>:rval}], :name=>"run_report_job_response"}, :input=>[{:type=>"ReportJob", :min_occurs=>0, :max_occurs=>1, :name=>:report_job}]}}
    REPORTSERVICE_TYPES = {:ExportFormat=>{:fields=>[]}, :ReportQuery=>{:fields=>[{:type=>"Dimension", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:dimensions}, {:type=>"Column", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:columns}, {:type=>"Date", :min_occurs=>0, :max_occurs=>1, :name=>:start_date}, {:type=>"Date", :min_occurs=>0, :max_occurs=>1, :name=>:end_date}, {:type=>"DateRangeType", :min_occurs=>0, :max_occurs=>1, :name=>:date_range_type}, {:type=>"DimensionFilter", :min_occurs=>0, :max_occurs=>:unbounded, :name=>:dimension_filters}]}, :ReportJobStatus=>{:fields=>[]}, :Column=>{:fields=>[]}, :Authentication=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:authentication_type}], :abstract=>true}, :DateRangeType=>{:fields=>[]}, :OAuth=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:parameters}], :base=>"Authentication"}, :Date=>{:fields=>[{:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:year}, {:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:month}, {:type=>"int", :min_occurs=>0, :max_occurs=>1, :name=>:day}]}, :Dimension=>{:fields=>[]}, :SoapRequestHeader=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:network_code}, {:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:application_name}, {:type=>"Authentication", :min_occurs=>0, :max_occurs=>1, :name=>:authentication}]}, :ClientLogin=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:token}], :base=>"Authentication"}, :DimensionFilter=>{:fields=>[]}, :SoapResponseHeader=>{:fields=>[{:type=>"string", :min_occurs=>0, :max_occurs=>1, :name=>:request_id}, {:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:response_time}]}, :ReportJob=>{:fields=>[{:type=>"long", :min_occurs=>0, :max_occurs=>1, :name=>:id}, {:type=>"ReportQuery", :min_occurs=>0, :max_occurs=>1, :name=>:report_query}, {:type=>"ReportJobStatus", :min_occurs=>0, :max_occurs=>1, :name=>:report_job_status}]}}
    REPORTSERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return REPORTSERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return REPORTSERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return REPORTSERVICE_NAMESPACES[index]
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
