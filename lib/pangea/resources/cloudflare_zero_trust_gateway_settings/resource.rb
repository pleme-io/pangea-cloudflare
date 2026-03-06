# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_gateway_settings/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustGatewaySettings
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_gateway_settings,
      attributes_class: Cloudflare::Types::ZeroTrustGatewaySettingsAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustGatewaySettings
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
