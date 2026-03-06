# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_managed_transforms/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareManagedTransforms
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_managed_transforms,
      attributes_class: Cloudflare::Types::ManagedTransformsAttributes,
      map: [:zone_id] do |r, attrs|
      if attrs.managed_request_headers
        r.managed_request_headers do
          attrs.managed_request_headers.each { |k, v| send(k.to_sym, v) }
        end
      end
      if attrs.managed_response_headers
        r.managed_response_headers do
          attrs.managed_response_headers.each { |k, v| send(k.to_sym, v) }
        end
      end
    end
  end
  module Cloudflare
    include CloudflareManagedTransforms
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
