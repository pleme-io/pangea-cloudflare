# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_user/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareUser
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_user,
      attributes_class: Cloudflare::Types::UserAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareUser
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
