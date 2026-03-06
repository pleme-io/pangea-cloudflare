# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_r2_custom_domain/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareR2CustomDomain
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_r2_custom_domain,
      attributes_class: Cloudflare::Types::R2CustomDomainAttributes,
      map: [:account_id, :bucket_name, :domain]
  end
  module Cloudflare
    include CloudflareR2CustomDomain
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
