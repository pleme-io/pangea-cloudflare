# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_content_scanning_expression/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareContentScanningExpression
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_content_scanning_expression,
      attributes_class: Cloudflare::Types::ContentScanningExpressionAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareContentScanningExpression
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
