# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_dex_test/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustDexTest
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_dex_test,
      attributes_class: Cloudflare::Types::ZeroTrustDexTestAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustDexTest
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
