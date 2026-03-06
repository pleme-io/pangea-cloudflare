# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_cloudforce_one_request_asset/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareCloudforceOneRequestAsset
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_cloudforce_one_request_asset,
      attributes_class: Cloudflare::Types::CloudforceOneRequestAssetAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareCloudforceOneRequestAsset
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
