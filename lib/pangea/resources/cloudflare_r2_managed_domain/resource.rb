# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_r2_managed_domain/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareR2ManagedDomain
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_r2_managed_domain,
      attributes_class: Cloudflare::Types::R2ManagedDomainAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareR2ManagedDomain
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
