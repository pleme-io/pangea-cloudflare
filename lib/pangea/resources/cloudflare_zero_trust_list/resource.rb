# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_list/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustList
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_list,
      attributes_class: Cloudflare::Types::ZeroTrustListAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustList
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
