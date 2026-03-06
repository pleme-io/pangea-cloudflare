# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_stream_audio_track/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareStreamAudioTrack
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_stream_audio_track,
      attributes_class: Cloudflare::Types::StreamAudioTrackAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareStreamAudioTrack
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
