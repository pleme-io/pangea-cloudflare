# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_api_shield/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareApiShield
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_api_shield,
      attributes_class: Cloudflare::Types::ApiShieldAttributes,
      map: [:zone_id],
      map_present: [:auth_id_characteristics]
  end
  module Cloudflare
    include CloudflareApiShield
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
