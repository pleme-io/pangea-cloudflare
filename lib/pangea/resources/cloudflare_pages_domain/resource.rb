# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_pages_domain/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflarePagesDomain
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_pages_domain,
      attributes_class: Cloudflare::Types::PagesDomainAttributes,
      map: [:account_id, :project_name, :domain]
  end
  module Cloudflare
    include CloudflarePagesDomain
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
