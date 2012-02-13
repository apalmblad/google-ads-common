#!/usr/bin/ruby
# This is auto-generated code, changes will be overwritten.
# Copyright:: Copyright 2011, Google Inc. All Rights Reserved.
# License:: Licensed under the Apache License,Version 2.0 (the "License").
#
# Code generated by AdsCommon library 0.6.1 on 2011-12-20 18:02:31.

require 'ads_common/savon_service'
require 'dfp_api/v201103/line_item_creative_association_service_registry'

module DfpApi; module V201103; module LineItemCreativeAssociationService
  class LineItemCreativeAssociationService < AdsCommon::SavonService
    def initialize(api, endpoint)
      namespace = 'https://www.google.com/apis/ads/publisher/v201103'
      super(api, endpoint, namespace, :v201103)
    end

    def get_line_item_creative_association(*args, &block)
      return execute_action('get_line_item_creative_association', args, &block)
    end

    def get_line_item_creative_associations_by_statement(*args, &block)
      return execute_action('get_line_item_creative_associations_by_statement', args, &block)
    end

    def perform_line_item_creative_association_action(*args, &block)
      return execute_action('perform_line_item_creative_association_action', args, &block)
    end

    def update_line_item_creative_association(*args, &block)
      return execute_action('update_line_item_creative_association', args, &block)
    end

    def create_line_item_creative_association(*args, &block)
      return execute_action('create_line_item_creative_association', args, &block)
    end

    def update_line_item_creative_associations(*args, &block)
      return execute_action('update_line_item_creative_associations', args, &block)
    end

    def create_line_item_creative_associations(*args, &block)
      return execute_action('create_line_item_creative_associations', args, &block)
    end

    private

    def get_service_registry()
      return LineItemCreativeAssociationServiceRegistry
    end

    def get_module()
      return DfpApi::V201103::LineItemCreativeAssociationService
    end
  end
end; end; end