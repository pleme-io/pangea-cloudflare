# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_email_routing_dns/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareEmailRoutingDns
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_email_routing_dns,
      attributes_class: Cloudflare::Types::EmailRoutingDnsAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareEmailRoutingDns
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
