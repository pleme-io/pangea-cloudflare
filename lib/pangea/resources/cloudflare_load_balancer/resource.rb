# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_load_balancer/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareLoadBalancer
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_load_balancer,
      attributes_class: Cloudflare::Types::LoadBalancerAttributes,
      outputs: { id: :id, created_on: :created_on, modified_on: :modified_on },
      map: [:zone_id, :name, :default_pool_ids, :steering_policy, :session_affinity, :proxied, :enabled],
      map_present: [:fallback_pool_id, :description, :ttl, :session_affinity_ttl] do |r, attrs|
      if attrs.session_affinity_attributes
        r.session_affinity_attributes do
          attrs.session_affinity_attributes.each do |key, value|
            public_send(key, value)
          end
        end
      end
      attrs.region_pools.each do |region_pool|
        r.region_pools do
          region region_pool[:region]
          pool_ids region_pool[:pool_ids]
        end
      end
      attrs.pop_pools.each do |pop_pool|
        r.pop_pools do
          pop pop_pool[:pop]
          pool_ids pop_pool[:pool_ids]
        end
      end
    end
  end
  module Cloudflare
    include CloudflareLoadBalancer
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
