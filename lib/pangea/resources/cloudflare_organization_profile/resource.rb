# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_organization_profile/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareOrganizationProfile
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_organization_profile,
      attributes_class: Cloudflare::Types::OrganizationProfileAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareOrganizationProfile
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
