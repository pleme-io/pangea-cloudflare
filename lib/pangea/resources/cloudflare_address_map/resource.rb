# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_address_map/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareAddressMap
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_address_map,
      attributes_class: Cloudflare::Types::AddressMapAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareAddressMap
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
