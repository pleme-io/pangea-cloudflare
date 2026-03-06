# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zone_cache_reserve/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZoneCacheReserve
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zone_cache_reserve,
      attributes_class: Cloudflare::Types::ZoneCacheReserveAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareZoneCacheReserve
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
