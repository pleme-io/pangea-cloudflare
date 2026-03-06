# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_argo/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareArgo
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_argo,
      attributes_class: Cloudflare::Types::ArgoAttributes,
      map: [:zone_id],
      map_present: [:smart_routing, :tiered_caching]
  end
  module Cloudflare
    include CloudflareArgo
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
