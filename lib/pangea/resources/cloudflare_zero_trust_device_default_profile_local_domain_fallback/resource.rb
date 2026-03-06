# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_device_default_profile_local_domain_fallback/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareDeviceDefaultProfileLocalDomainFallback
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_device_default_profile_local_domain_fallback,
      attributes_class: Cloudflare::Types::ZeroTrustDeviceDefaultProfileLocalDomainFallbackAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareDeviceDefaultProfileLocalDomainFallback
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
