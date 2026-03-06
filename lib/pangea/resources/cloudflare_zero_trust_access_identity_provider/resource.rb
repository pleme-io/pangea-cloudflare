# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_access_identity_provider/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustAccessIdentityProvider
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_access_identity_provider,
      attributes_class: Cloudflare::Types::ZeroTrustAccessIdentityProviderAttributes,
      map: [:name, :type],
      map_present: [:account_id, :zone_id, :config, :scim_config]
  end
  module Cloudflare
    include CloudflareZeroTrustAccessIdentityProvider
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
