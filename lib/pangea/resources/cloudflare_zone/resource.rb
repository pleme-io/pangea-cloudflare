# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zone/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZone
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zone,
      attributes_class: Cloudflare::Types::ZoneAttributes,
      outputs: { id: :id, zone_id: :id, status: :status, name_servers: :name_servers, vanity_name_servers: :vanity_name_servers, verification_key: :verification_key, meta: :meta },
      map: [:zone, :jump_start, :paused, :plan, :type],
      map_present: [:account_id]
  end
  module Cloudflare
    include CloudflareZone
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
