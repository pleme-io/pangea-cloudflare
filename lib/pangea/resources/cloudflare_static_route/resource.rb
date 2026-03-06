# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_static_route/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareStaticRoute
    include Pangea::Resources::ResourceBuilder

    # Note: cloudflare_static_route is deprecated, maps to cloudflare_magic_wan_static_route
    define_resource :cloudflare_magic_wan_static_route,
      attributes_class: Cloudflare::Types::StaticRouteAttributes,
      map: [:account_id, :prefix, :nexthop, :priority],
      map_present: [:description, :weight] do |r, attrs|
      if attrs.scope
        r.scope do
          colo_names attrs.scope.colo_names if attrs.scope.colo_names
          colo_regions attrs.scope.colo_regions if attrs.scope.colo_regions
        end
      end
    end

    # Alias: the module defines cloudflare_magic_wan_static_route,
    # alias provides the legacy cloudflare_static_route name
    alias cloudflare_static_route cloudflare_magic_wan_static_route
  end
  module Cloudflare
    include CloudflareStaticRoute
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
