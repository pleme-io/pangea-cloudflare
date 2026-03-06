# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zone_lockdown/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZoneLockdown
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zone_lockdown,
      attributes_class: Cloudflare::Types::ZoneLockdownAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareZoneLockdown
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
