# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_regional_hostname/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareRegionalHostname
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_regional_hostname,
      attributes_class: Cloudflare::Types::RegionalHostnameAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareRegionalHostname
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
