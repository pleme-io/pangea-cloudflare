# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_cloudforce_one_request_message/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareCloudforceOneRequestMessage
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_cloudforce_one_request_message,
      attributes_class: Cloudflare::Types::CloudforceOneRequestMessageAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareCloudforceOneRequestMessage
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
