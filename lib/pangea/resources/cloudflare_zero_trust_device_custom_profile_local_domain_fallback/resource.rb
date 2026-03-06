# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_device_custom_profile_local_domain_fallback/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareDeviceCustomProfileLocalDomainFallback
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_device_custom_profile_local_domain_fallback,
      attributes_class: Cloudflare::Types::ZeroTrustDeviceCustomProfileLocalDomainFallbackAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareDeviceCustomProfileLocalDomainFallback
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
