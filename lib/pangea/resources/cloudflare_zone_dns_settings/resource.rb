# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zone_dns_settings/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZoneDnsSettings
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zone_dns_settings,
      attributes_class: Cloudflare::Types::ZoneDnsSettingsAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareZoneDnsSettings
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
