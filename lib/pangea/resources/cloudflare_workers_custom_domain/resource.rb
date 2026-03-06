# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_workers_custom_domain/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWorkersCustomDomain
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_workers_custom_domain,
      attributes_class: Cloudflare::Types::WorkersCustomDomainAttributes,
      outputs: { id: :id, domain_id: :id, zone_name: :zone_name },
      map: [:account_id, :zone_id, :hostname, :service, :environment]
  end
  module Cloudflare
    include CloudflareWorkersCustomDomain
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
