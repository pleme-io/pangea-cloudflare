# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_api_shield_discovery_operation/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareApiShieldDiscoveryOperation
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_api_shield_discovery_operation,
      attributes_class: Cloudflare::Types::ApiShieldDiscoveryOperationAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareApiShieldDiscoveryOperation
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
