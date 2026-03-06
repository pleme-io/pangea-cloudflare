# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_user_agent_blocking_rule/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareUserAgentBlockingRule
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_user_agent_blocking_rule,
      attributes_class: Cloudflare::Types::UserAgentBlockingRuleAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareUserAgentBlockingRule
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
