# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_waiting_room/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWaitingRoom
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_waiting_room,
      attributes_class: Cloudflare::Types::WaitingRoomAttributes,
      map: [:zone_id, :host, :name, :new_users_per_minute, :total_active_users],
      map_present: [:path, :queue_all, :queueing_method, :description, :session_duration, :suspended, :custom_page_html, :default_template_language, :json_response_enabled, :queueing_status_code] do |r, attrs|
      r.disable_session_renewal attrs.disable_session_renewal unless attrs.disable_session_renewal.nil?
      if attrs.cookie_attributes
        r.cookie_attributes do
          samesite attrs.cookie_attributes.samesite if attrs.cookie_attributes.samesite
          secure attrs.cookie_attributes.secure if attrs.cookie_attributes.secure
        end
      end
    end
  end
  module Cloudflare
    include CloudflareWaitingRoom
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
