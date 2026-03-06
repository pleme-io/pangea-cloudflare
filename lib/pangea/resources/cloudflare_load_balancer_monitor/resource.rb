# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_load_balancer_monitor/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareLoadBalancerMonitor
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_load_balancer_monitor,
      attributes_class: Cloudflare::Types::LoadBalancerMonitorAttributes,
      outputs: { id: :id, created_on: :created_on, modified_on: :modified_on },
      map: [:account_id, :type, :expected_codes, :timeout, :path, :interval, :retries, :allow_insecure, :follow_redirects],
      map_present: [:description, :probe_zone] do |r, attrs|
      __send__(:method_missing, :method, attrs[:method])  # Use method_missing directly to avoid Object#method
      if attrs.header.any?
        r.header attrs.header.map { |name, values| { name: name, values: values } }
      end
    end
  end
  module Cloudflare
    include CloudflareLoadBalancerMonitor
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
