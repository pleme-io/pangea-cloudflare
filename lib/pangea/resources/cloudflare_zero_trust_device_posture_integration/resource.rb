# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_device_posture_integration/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustDevicePostureIntegration
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_device_posture_integration,
      attributes_class: Cloudflare::Types::ZeroTrustDevicePostureIntegrationAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustDevicePostureIntegration
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
