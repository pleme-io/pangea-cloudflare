# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zone_hold/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZoneHold
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zone_hold,
      attributes_class: Cloudflare::Types::ZoneHoldAttributes,
      map: [:zone_id]
  end
  module Cloudflare
    include CloudflareZoneHold
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
