# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_total_tls/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareTotalTls
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_total_tls,
      attributes_class: Cloudflare::Types::TotalTlsAttributes,
      map: [:zone_id]
  end
  module Cloudflare
    include CloudflareTotalTls
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
