# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_organization/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustOrganization
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_organization,
      attributes_class: Cloudflare::Types::ZeroTrustOrganizationAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustOrganization
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
