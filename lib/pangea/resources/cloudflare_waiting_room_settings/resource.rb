# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_waiting_room_settings/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWaitingRoomSettings
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_waiting_room_settings,
      attributes_class: Cloudflare::Types::WaitingRoomSettingsAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareWaitingRoomSettings
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
