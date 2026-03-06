# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_authenticated_origin_pulls_settings/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareAuthenticatedOriginPullsSettings
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_authenticated_origin_pulls_settings,
      attributes_class: Cloudflare::Types::AuthenticatedOriginPullsSettingsAttributes,
      map: [:zone_id]
  end
  module Cloudflare
    include CloudflareAuthenticatedOriginPullsSettings
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
