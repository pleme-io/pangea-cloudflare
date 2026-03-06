# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_schema_validation_operation_settings/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareSchemaValidationOperationSettings
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_schema_validation_operation_settings,
      attributes_class: Cloudflare::Types::SchemaValidationOperationSettingsAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareSchemaValidationOperationSettings
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
