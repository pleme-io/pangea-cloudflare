# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_api_shield_operation/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareApiShieldOperation
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_api_shield_operation,
      attributes_class: Cloudflare::Types::ApiShieldOperationAttributes,
      map: [:zone_id, :host, :endpoint] do |r, attrs|
      r.method_missing(:method, attrs[:method])
    end
  end
  module Cloudflare
    include CloudflareApiShieldOperation
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
