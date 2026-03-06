# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_cloudforce_one_request_priority/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareCloudforceOneRequestPriority
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_cloudforce_one_request_priority,
      attributes_class: Cloudflare::Types::CloudforceOneRequestPriorityAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareCloudforceOneRequestPriority
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
