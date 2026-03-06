# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_tunnel_cloudflared/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustTunnelCloudflared
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_tunnel_cloudflared,
      attributes_class: Cloudflare::Types::ZeroTrustTunnelCloudflaredAttributes,
      outputs: { id: :id, cname: :cname, tunnel_token: :tunnel_token },
      map: [:account_id, :name, :secret],
      map_present: [:config_src]
  end
  module Cloudflare
    include CloudflareZeroTrustTunnelCloudflared
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
