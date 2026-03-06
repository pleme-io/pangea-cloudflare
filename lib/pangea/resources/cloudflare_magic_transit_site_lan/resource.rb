# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_magic_transit_site_lan/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareMagicTransitSiteLan
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_magic_transit_site_lan,
      attributes_class: Cloudflare::Types::MagicTransitSiteLanAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareMagicTransitSiteLan
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
