# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_device_custom_profile/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareDeviceCustomProfile
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_device_custom_profile,
      attributes_class: Cloudflare::Types::ZeroTrustDeviceCustomProfileAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareDeviceCustomProfile
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
