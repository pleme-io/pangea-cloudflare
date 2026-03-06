# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_stream_download/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareStreamDownload
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_stream_download,
      attributes_class: Cloudflare::Types::StreamDownloadAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareStreamDownload
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
