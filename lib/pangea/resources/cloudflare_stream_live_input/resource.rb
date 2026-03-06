# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_stream_live_input/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareStreamLiveInput
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_stream_live_input,
      attributes_class: Cloudflare::Types::StreamLiveInputAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareStreamLiveInput
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
