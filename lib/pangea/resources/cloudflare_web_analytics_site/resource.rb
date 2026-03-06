# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_web_analytics_site/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWebAnalyticsSite
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_web_analytics_site,
      attributes_class: Cloudflare::Types::WebAnalyticsSiteAttributes,
      outputs: { id: :id, site_tag: :site_tag, site_token: :site_token },
      map: [:account_id, :auto_install],
      map_present: [:host, :zone_tag]
  end
  module Cloudflare
    include CloudflareWebAnalyticsSite
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
