# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_magic_transit_site_acl/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareMagicTransitSiteAcl
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_magic_transit_site_acl,
      attributes_class: Cloudflare::Types::MagicTransitSiteAclAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareMagicTransitSiteAcl
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
