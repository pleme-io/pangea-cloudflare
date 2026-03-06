# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_custom_hostname_fallback_origin/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareCustomHostnameFallbackOrigin
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_custom_hostname_fallback_origin,
      attributes_class: Cloudflare::Types::CustomHostnameFallbackOriginAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareCustomHostnameFallbackOrigin
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
