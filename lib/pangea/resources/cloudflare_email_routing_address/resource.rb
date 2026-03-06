# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_email_routing_address/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareEmailRoutingAddress
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_email_routing_address,
      attributes_class: Cloudflare::Types::EmailRoutingAddressAttributes,
      map: [:zone_id]
  end
  module Cloudflare
    include CloudflareEmailRoutingAddress
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
