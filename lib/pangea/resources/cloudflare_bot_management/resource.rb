# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_bot_management/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareBotManagement
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_bot_management,
      attributes_class: Cloudflare::Types::BotManagementAttributes,
      map: [:zone_id],
      map_bool: [:enable_js, :fight_mode, :suppress_session_score, :auto_update_model, :optimize_wordpress]
  end
  module Cloudflare
    include CloudflareBotManagement
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
