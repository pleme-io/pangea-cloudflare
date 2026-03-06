# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_rate_limit/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareRateLimit
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_rate_limit,
      attributes_class: Cloudflare::Types::RateLimitAttributes,
      outputs: { id: :id, rule_id: :id },
      map: [:zone_id, :threshold, :period],
      map_present: [:description, :disabled, :bypass_url_patterns] do |r, attrs|
      r.action do
        mode attrs.action_mode
        timeout attrs.action_timeout if attrs.action_timeout
      end
      if attrs.match_request_url || attrs.match_request_methods ||
         attrs.match_request_schemes || attrs.match_response_status
        r.match do
          request do
            url_pattern attrs.match_request_url if attrs.match_request_url
            methods attrs.match_request_methods if attrs.match_request_methods
            schemes attrs.match_request_schemes if attrs.match_request_schemes
          end
          if attrs.match_response_status
            response do
              status attrs.match_response_status
            end
          end
        end
      end
    end
  end
  module Cloudflare
    include CloudflareRateLimit
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
