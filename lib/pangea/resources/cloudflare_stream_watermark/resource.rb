# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_stream_watermark/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareStreamWatermark
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_stream_watermark,
      attributes_class: Cloudflare::Types::StreamWatermarkAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareStreamWatermark
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
