# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_calls_turn_app/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareCallsTurnApp
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_calls_turn_app,
      attributes_class: Cloudflare::Types::CallsTurnAppAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareCallsTurnApp
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
