# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_web3_hostname/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWeb3Hostname
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_web3_hostname,
      attributes_class: Cloudflare::Types::Web3HostnameAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareWeb3Hostname
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
