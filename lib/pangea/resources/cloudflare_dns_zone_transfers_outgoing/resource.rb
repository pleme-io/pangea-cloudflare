# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_dns_zone_transfers_outgoing/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareDnsZoneTransfersOutgoing
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_dns_zone_transfers_outgoing,
      attributes_class: Cloudflare::Types::DnsZoneTransfersOutgoingAttributes,
      map: [:zone_id]
  end
  module Cloudflare
    include CloudflareDnsZoneTransfersOutgoing
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
