# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_access_custom_page/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustAccessCustomPage
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_access_custom_page,
      attributes_class: Cloudflare::Types::ZeroTrustAccessCustomPageAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustAccessCustomPage
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
