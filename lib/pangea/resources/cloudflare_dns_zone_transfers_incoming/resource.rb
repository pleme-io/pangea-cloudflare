# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_dns_zone_transfers_incoming/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareDnsZoneTransfersIncoming
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_dns_zone_transfers_incoming,
      attributes_class: Cloudflare::Types::DnsZoneTransfersIncomingAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareDnsZoneTransfersIncoming
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
