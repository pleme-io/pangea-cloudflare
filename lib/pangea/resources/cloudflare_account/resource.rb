# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_account/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareAccount
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_account,
      attributes_class: Cloudflare::Types::AccountAttributes,
      map: [:name],
      map_present: [:type],
      map_bool: [:enforce_twofactor]
  end
  module Cloudflare
    include CloudflareAccount
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
