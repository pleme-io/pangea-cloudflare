# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_tunnel_cloudflared_virtual_network/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustTunnelCloudflaredVirtualNetwork
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_tunnel_cloudflared_virtual_network,
      attributes_class: Cloudflare::Types::ZeroTrustTunnelCloudflaredVirtualNetworkAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustTunnelCloudflaredVirtualNetwork
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
