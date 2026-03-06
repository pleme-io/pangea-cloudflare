# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_access_service_token/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustAccessServiceToken
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_access_service_token,
      attributes_class: Cloudflare::Types::ZeroTrustAccessServiceTokenAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustAccessServiceToken
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
