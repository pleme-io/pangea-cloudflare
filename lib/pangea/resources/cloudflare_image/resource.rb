# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_image/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareImage
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_image,
      attributes_class: Cloudflare::Types::ImageAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareImage
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
