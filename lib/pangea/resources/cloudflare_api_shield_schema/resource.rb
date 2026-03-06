# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_api_shield_schema/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareApiShieldSchema
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_api_shield_schema,
      attributes_class: Cloudflare::Types::ApiShieldSchemaAttributes,
      map: [:zone_id, :name, :source],
      map_present: [:kind],
      map_bool: [:validation_enabled]
  end
  module Cloudflare
    include CloudflareApiShieldSchema
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
