# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_account_dns_settings_internal_view/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareAccountDnsSettingsInternalView
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_account_dns_settings_internal_view,
      attributes_class: Cloudflare::Types::AccountDnsSettingsInternalViewAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareAccountDnsSettingsInternalView
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
