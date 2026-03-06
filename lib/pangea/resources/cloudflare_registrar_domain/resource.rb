# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_registrar_domain/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareRegistrarDomain
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_registrar_domain,
      attributes_class: Cloudflare::Types::RegistrarDomainAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareRegistrarDomain
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
