# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_magic_wan_static_route/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareMagicWanStaticRoute
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_magic_wan_static_route,
      attributes_class: Cloudflare::Types::MagicWanStaticRouteAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareMagicWanStaticRoute
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
