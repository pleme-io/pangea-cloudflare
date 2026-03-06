# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_gateway_policy/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustGatewayPolicy
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_gateway_policy,
      attributes_class: Cloudflare::Types::ZeroTrustGatewayPolicyAttributes,
      map: [:account_id, :name, :action, :precedence],
      map_present: [:description, :traffic, :filters, :rule_settings],
      map_bool: [:enabled]
  end
  module Cloudflare
    include CloudflareZeroTrustGatewayPolicy
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
