# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_magic_transit_connector/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareMagicTransitConnector
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_magic_transit_connector,
      attributes_class: Cloudflare::Types::MagicTransitConnectorAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareMagicTransitConnector
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
