# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_tiered_cache/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareTieredCache
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_tiered_cache,
      attributes_class: Cloudflare::Types::TieredCacheAttributes,
      outputs: { id: :id, editable: :editable, modified_on: :modified_on },
      map: [:zone_id, :value]
  end
  module Cloudflare
    include CloudflareTieredCache
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
