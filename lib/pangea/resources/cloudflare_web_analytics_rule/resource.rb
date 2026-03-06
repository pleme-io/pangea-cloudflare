# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_web_analytics_rule/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWebAnalyticsRule
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_web_analytics_rule,
      attributes_class: Cloudflare::Types::WebAnalyticsRuleAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareWebAnalyticsRule
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
