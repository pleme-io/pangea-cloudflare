# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_access_rule/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareAccessRule
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_access_rule,
      attributes_class: Cloudflare::Types::AccessRuleAttributes,
      outputs: { id: :id, rule_id: :id },
      map: [:mode],
      map_present: [:zone_id, :account_id, :notes] do |r, attrs|
      r.configuration do
        target attrs.target
        value attrs.value
      end
    end
  end
  module Cloudflare
    include CloudflareAccessRule
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
