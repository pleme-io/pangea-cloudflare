# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_byo_ip_prefix/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareByoIpPrefix
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_byo_ip_prefix,
      attributes_class: Cloudflare::Types::ByoIpPrefixAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareByoIpPrefix
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
