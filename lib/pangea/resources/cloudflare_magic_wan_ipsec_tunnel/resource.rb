# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_magic_wan_ipsec_tunnel/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareMagicWanIpsecTunnel
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_magic_wan_ipsec_tunnel,
      attributes_class: Cloudflare::Types::MagicWanIpsecTunnelAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareMagicWanIpsecTunnel
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
