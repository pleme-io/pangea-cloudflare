# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_record/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareRecord
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_record,
      attributes_class: Cloudflare::Types::RecordAttributes,
      outputs: { id: :id, hostname: :hostname, proxiable: :proxiable, created_on: :created_on, modified_on: :modified_on, metadata: :metadata },
      map: [:zone_id, :name, :type, :ttl],
      map_present: [:value, :priority, :comment] do |r, attrs|
      r.proxied attrs.proxied if attrs.can_be_proxied? && attrs.proxied
      if attrs.data
        r.data do
          attrs.data.each do |key, value|
            public_send(key, value) if value
          end
        end
      end
      if attrs.tags.any?
        r.tags do
          attrs.tags.each do |key, value|
            public_send(key, value)
          end
        end
      end
    end
  end
  module Cloudflare
    include CloudflareRecord
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
