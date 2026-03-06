# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_network_hostname_route/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustNetworkHostnameRoute
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_network_hostname_route,
      attributes_class: Cloudflare::Types::ZeroTrustNetworkHostnameRouteAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustNetworkHostnameRoute
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
