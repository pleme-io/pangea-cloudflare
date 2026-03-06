# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_device_default_profile_certificates/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareDeviceDefaultProfileCertificates
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_device_default_profile_certificates,
      attributes_class: Cloudflare::Types::ZeroTrustDeviceDefaultProfileCertificatesAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareDeviceDefaultProfileCertificates
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
