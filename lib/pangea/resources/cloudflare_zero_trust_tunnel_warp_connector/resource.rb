# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_tunnel_warp_connector/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustTunnelWarpConnector
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_tunnel_warp_connector,
      attributes_class: Cloudflare::Types::ZeroTrustTunnelWarpConnectorAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustTunnelWarpConnector
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
