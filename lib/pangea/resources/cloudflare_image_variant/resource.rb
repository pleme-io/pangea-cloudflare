# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_image_variant/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareImageVariant
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_image_variant,
      attributes_class: Cloudflare::Types::ImageVariantAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareImageVariant
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
