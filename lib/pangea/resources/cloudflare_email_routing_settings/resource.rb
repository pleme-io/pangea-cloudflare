# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_email_routing_settings/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareEmailRoutingSettings
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_email_routing_settings,
      attributes_class: Cloudflare::Types::EmailRoutingSettingsAttributes,
      map: [:zone_id]
  end
  module Cloudflare
    include CloudflareEmailRoutingSettings
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
