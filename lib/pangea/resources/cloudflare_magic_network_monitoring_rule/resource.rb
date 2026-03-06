# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_magic_network_monitoring_rule/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareMagicNetworkMonitoringRule
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_magic_network_monitoring_rule,
      attributes_class: Cloudflare::Types::MagicNetworkMonitoringRuleAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareMagicNetworkMonitoringRule
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
