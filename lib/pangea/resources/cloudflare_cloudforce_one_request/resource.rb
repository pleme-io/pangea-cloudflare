# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_cloudforce_one_request/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareCloudforceOneRequest
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_cloudforce_one_request,
      attributes_class: Cloudflare::Types::CloudforceOneRequestAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareCloudforceOneRequest
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
