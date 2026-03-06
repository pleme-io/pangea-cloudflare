# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_stream_webhook/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareStreamWebhook
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_stream_webhook,
      attributes_class: Cloudflare::Types::StreamWebhookAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareStreamWebhook
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
