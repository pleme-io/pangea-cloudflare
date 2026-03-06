# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_access_infrastructure_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustAccessInfrastructureTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_access_infrastructure_target,
      attributes_class: Cloudflare::Types::ZeroTrustAccessInfrastructureTargetAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustAccessInfrastructureTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
