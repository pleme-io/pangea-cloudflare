# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_dns_firewall/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareDnsFirewall
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_dns_firewall,
      attributes_class: Cloudflare::Types::DnsFirewallAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareDnsFirewall
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
