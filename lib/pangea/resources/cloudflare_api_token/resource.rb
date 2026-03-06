# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_api_token/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareApiToken
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_api_token,
      attributes_class: Cloudflare::Types::ApiTokenAttributes,
      outputs: { id: :id, value: :value },
      map: [:name, :policy],
      map_present: [:condition, :expires_on, :not_before]
  end
  module Cloudflare
    include CloudflareApiToken
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
