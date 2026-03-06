# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_email_routing_rule/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareEmailRoutingRule
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_email_routing_rule,
      attributes_class: Cloudflare::Types::EmailRoutingRuleAttributes,
      map: [:zone_id]
  end
  module Cloudflare
    include CloudflareEmailRoutingRule
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
