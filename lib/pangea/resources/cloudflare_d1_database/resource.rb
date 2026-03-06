# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_d1_database/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareD1Database
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_d1_database,
      attributes_class: Cloudflare::Types::D1DatabaseAttributes,
      outputs: { id: :id, database_id: :id, database_name: :name, version: :version },
      map: [:account_id, :name],
      map_present: [:primary_location_hint]
  end
  module Cloudflare
    include CloudflareD1Database
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
