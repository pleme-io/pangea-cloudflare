# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_ruleset/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareRuleset
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_ruleset,
      attributes_class: Cloudflare::Types::RulesetAttributes,
      map: [:name, :kind, :phase],
      map_present: [:zone_id, :account_id, :description] do |r, attrs|
      if attrs.rules.any?
        r.rules attrs.rules.map { |r| r.to_h }
      end
    end
  end
  module Cloudflare
    include CloudflareRuleset
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
