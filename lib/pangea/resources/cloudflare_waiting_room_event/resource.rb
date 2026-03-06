# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_waiting_room_event/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWaitingRoomEvent
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_waiting_room_event,
      attributes_class: Cloudflare::Types::WaitingRoomEventAttributes,
      map: [:zone_id, :waiting_room_id, :name, :event_start_time, :event_end_time],
      map_present: [:description, :prequeue_start_time, :new_users_per_minute, :total_active_users, :queueing_method, :session_duration, :disable_session_renewal, :shuffle_at_event_start, :suspended, :custom_page_html]
  end
  module Cloudflare
    include CloudflareWaitingRoomEvent
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
