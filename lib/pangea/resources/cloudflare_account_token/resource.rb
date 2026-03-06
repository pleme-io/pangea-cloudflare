# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_account_token/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareAccountToken
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_account_token,
      attributes_class: Cloudflare::Types::AccountTokenAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareAccountToken
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
