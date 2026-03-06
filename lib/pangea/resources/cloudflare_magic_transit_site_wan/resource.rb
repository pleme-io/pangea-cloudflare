# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_magic_transit_site_wan/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareMagicTransitSiteWan
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_magic_transit_site_wan,
      attributes_class: Cloudflare::Types::MagicTransitSiteWanAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareMagicTransitSiteWan
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
