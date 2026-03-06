# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_firewall_rule/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareFirewallRule
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_firewall_rule,
      attributes_class: Cloudflare::Types::FirewallRuleAttributes,
      map: [:zone_id, :filter_id, :action, :paused],
      map_present: [:description, :priority] do |r, attrs|
      if attrs.products.any?
        r.products attrs.products
      end
    end
  end
  module Cloudflare
    include CloudflareFirewallRule
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
