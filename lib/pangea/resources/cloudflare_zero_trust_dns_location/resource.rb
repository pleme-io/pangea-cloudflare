# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_dns_location/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustDnsLocation
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_dns_location,
      attributes_class: Cloudflare::Types::ZeroTrustDnsLocationAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustDnsLocation
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
