# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_dns_zone_transfers_acl/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareDnsZoneTransfersAcl
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_dns_zone_transfers_acl,
      attributes_class: Cloudflare::Types::DnsZoneTransfersAclAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareDnsZoneTransfersAcl
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
