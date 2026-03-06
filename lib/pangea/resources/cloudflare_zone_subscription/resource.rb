# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zone_subscription/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZoneSubscription
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zone_subscription,
      attributes_class: Cloudflare::Types::ZoneSubscriptionAttributes,
      map: [:zone_id]
  end
  module Cloudflare
    include CloudflareZoneSubscription
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
