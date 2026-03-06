# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_snippet_rules/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareSnippetRules
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_snippet_rules,
      attributes_class: Cloudflare::Types::SnippetRulesAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareSnippetRules
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
