# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_stream/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareStream
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_stream,
      attributes_class: Cloudflare::Types::StreamAttributes,
      outputs: { id: :id, preview: :preview, playback_url: :playback_url },
      map: [:account_id],
      map_present: [:name, :meta, :allowed_origins, :thumbnail_timestamp_pct],
      map_bool: [:require_signed_urls]
  end
  module Cloudflare
    include CloudflareStream
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
