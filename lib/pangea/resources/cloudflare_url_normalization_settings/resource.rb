# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_url_normalization_settings/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareURLNormalizationSettings
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_url_normalization_settings,
      attributes_class: Cloudflare::Types::URLNormalizationSettingsAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareURLNormalizationSettings
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
