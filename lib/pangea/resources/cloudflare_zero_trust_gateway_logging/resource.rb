# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_gateway_logging/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustGatewayLogging
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_gateway_logging,
      attributes_class: Cloudflare::Types::ZeroTrustGatewayLoggingAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustGatewayLogging
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
