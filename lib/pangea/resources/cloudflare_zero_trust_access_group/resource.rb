# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_access_group/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustAccessGroup
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_access_group,
      attributes_class: Cloudflare::Types::ZeroTrustAccessGroupAttributes,
      map: [:name, :include],
      map_present: [:account_id, :zone_id, :exclude, :require]
  end
  module Cloudflare
    include CloudflareZeroTrustAccessGroup
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
