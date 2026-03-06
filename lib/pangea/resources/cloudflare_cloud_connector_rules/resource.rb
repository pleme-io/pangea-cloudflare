# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_cloud_connector_rules/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareCloudConnectorRules
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_cloud_connector_rules,
      attributes_class: Cloudflare::Types::CloudConnectorRulesAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareCloudConnectorRules
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
