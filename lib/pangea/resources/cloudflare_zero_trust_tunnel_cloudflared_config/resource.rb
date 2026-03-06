# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_tunnel_cloudflared_config/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustTunnelCloudflaredConfig
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_tunnel_cloudflared_config,
      attributes_class: Cloudflare::Types::ZeroTrustTunnelCloudflaredConfigAttributes,
      map: [:account_id, :tunnel_id, :config]
  end
  module Cloudflare
    include CloudflareZeroTrustTunnelCloudflaredConfig
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
