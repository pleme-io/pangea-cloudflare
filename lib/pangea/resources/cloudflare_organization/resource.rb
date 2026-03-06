# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_organization/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareOrganization
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_organization,
      attributes_class: Cloudflare::Types::OrganizationAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareOrganization
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
