# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_email_routing_catch_all/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareEmailRoutingCatchAll
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_email_routing_catch_all,
      attributes_class: Cloudflare::Types::EmailRoutingCatchAllAttributes,
      map: [:zone_id]
  end
  module Cloudflare
    include CloudflareEmailRoutingCatchAll
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
