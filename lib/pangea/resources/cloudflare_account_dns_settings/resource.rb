# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_account_dns_settings/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareAccountDnsSettings
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_account_dns_settings,
      attributes_class: Cloudflare::Types::AccountDnsSettingsAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareAccountDnsSettings
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
