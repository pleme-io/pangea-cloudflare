# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_dns_zone_transfers_peer/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareDnsZoneTransfersPeer
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_dns_zone_transfers_peer,
      attributes_class: Cloudflare::Types::DnsZoneTransfersPeerAttributes,
      map: [:zone_id]
  end
  module Cloudflare
    include CloudflareDnsZoneTransfersPeer
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
