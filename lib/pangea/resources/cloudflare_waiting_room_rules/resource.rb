# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_waiting_room_rules/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWaitingRoomRules
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_waiting_room_rules,
      attributes_class: Cloudflare::Types::WaitingRoomRulesAttributes,
      map: [:zone_id, :waiting_room_id] do |r, attrs|
      if attrs.rules.any?
        r.rules attrs.rules.map { |r| r.to_h }
      end
    end
  end
  module Cloudflare
    include CloudflareWaitingRoomRules
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
