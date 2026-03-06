# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_page_rule/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflarePageRule
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_page_rule,
      attributes_class: Cloudflare::Types::PageRuleAttributes,
      map: [:zone_id, :target, :priority, :status] do |r, attrs|
      r.actions do
        attrs.actions.each do |action_name, action_value|
          if action_value.is_a?(Hash)
            public_send(action_name) do
              action_value.each do |k, v|
                public_send(k, v)
              end
            end
          else
            public_send(action_name, action_value)
          end
        end
      end
    end
  end
  module Cloudflare
    include CloudflarePageRule
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
