# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_magic_transit_site/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareMagicTransitSite
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_magic_transit_site,
      attributes_class: Cloudflare::Types::MagicTransitSiteAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareMagicTransitSite
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
