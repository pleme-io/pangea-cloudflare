# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zone_cache_variants/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZoneCacheVariants
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zone_cache_variants,
      attributes_class: Cloudflare::Types::ZoneCacheVariantsAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareZoneCacheVariants
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
