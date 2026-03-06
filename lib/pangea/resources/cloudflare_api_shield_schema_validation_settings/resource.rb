# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_api_shield_schema_validation_settings/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareApiShieldSchemaValidationSettings
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_api_shield_schema_validation_settings,
      attributes_class: Cloudflare::Types::ApiShieldSchemaValidationSettingsAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareApiShieldSchemaValidationSettings
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
