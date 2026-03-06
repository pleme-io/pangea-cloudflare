# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_load_balancer_pool/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareLoadBalancerPool
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_load_balancer_pool,
      attributes_class: Cloudflare::Types::LoadBalancerPoolAttributes,
      outputs: { id: :id, created_on: :created_on, modified_on: :modified_on },
      map: [:account_id, :name, :enabled, :minimum_origins],
      map_present: [:description, :monitor, :notification_email] do |r, attrs|
      if attrs.check_regions
        r.check_regions attrs.check_regions
      end
      if attrs.origins.any?
        r.origin attrs.origins.map { |o| o.to_h }
      end
    end
  end
  module Cloudflare
    include CloudflareLoadBalancerPool
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
