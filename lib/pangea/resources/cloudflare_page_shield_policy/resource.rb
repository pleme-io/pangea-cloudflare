# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_page_shield_policy/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflarePageShieldPolicy
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_page_shield_policy,
      attributes_class: Cloudflare::Types::PageShieldPolicyAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflarePageShieldPolicy
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
