# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_device_managed_networks/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustDeviceManagedNetworks
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_device_managed_networks,
      attributes_class: Cloudflare::Types::ZeroTrustDeviceManagedNetworksAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustDeviceManagedNetworks
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
