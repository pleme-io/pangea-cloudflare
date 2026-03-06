# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_access_key_configuration/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustAccessKeyConfiguration
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_access_key_configuration,
      attributes_class: Cloudflare::Types::ZeroTrustAccessKeyConfigurationAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustAccessKeyConfiguration
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
