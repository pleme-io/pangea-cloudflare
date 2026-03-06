# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_magic_wan_gre_tunnel/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareMagicWanGreTunnel
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_magic_wan_gre_tunnel,
      attributes_class: Cloudflare::Types::MagicWanGreTunnelAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareMagicWanGreTunnel
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
