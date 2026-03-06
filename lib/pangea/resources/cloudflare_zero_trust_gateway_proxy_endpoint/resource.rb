# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_gateway_proxy_endpoint/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustGatewayProxyEndpoint
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_gateway_proxy_endpoint,
      attributes_class: Cloudflare::Types::ZeroTrustGatewayProxyEndpointAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustGatewayProxyEndpoint
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
