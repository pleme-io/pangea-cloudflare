# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_dns_zone_transfers_tsig/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareDnsZoneTransfersTsig
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_dns_zone_transfers_tsig,
      attributes_class: Cloudflare::Types::DnsZoneTransfersTsigAttributes,
      map: [:zone_id]
  end
  module Cloudflare
    include CloudflareDnsZoneTransfersTsig
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
