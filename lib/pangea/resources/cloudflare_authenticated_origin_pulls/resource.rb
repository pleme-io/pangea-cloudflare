# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_authenticated_origin_pulls/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareAuthenticatedOriginPulls
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_authenticated_origin_pulls,
      attributes_class: Cloudflare::Types::AuthenticatedOriginPullsAttributes,
      map: [:zone_id, :enabled],
      map_present: [:authenticated_origin_pulls_certificate, :hostname]
  end
  module Cloudflare
    include CloudflareAuthenticatedOriginPulls
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
