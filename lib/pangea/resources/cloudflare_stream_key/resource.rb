# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_stream_key/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareStreamKey
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_stream_key,
      attributes_class: Cloudflare::Types::StreamKeyAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareStreamKey
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
