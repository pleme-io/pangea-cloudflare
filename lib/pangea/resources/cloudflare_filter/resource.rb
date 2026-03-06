# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_filter/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareFilter
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_filter,
      attributes_class: Cloudflare::Types::FilterAttributes,
      map: [:zone_id, :expression, :paused],
      map_present: [:description, :ref]
  end
  module Cloudflare
    include CloudflareFilter
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
