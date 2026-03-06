# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_custom_ssl/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareCustomSsl
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_custom_ssl,
      attributes_class: Cloudflare::Types::CustomSslAttributes,
      outputs: { id: :id, status: :status, expires_on: :expires_on },
      map: [:zone_id],
      map_present: [:certificate, :private_key, :bundle_method, :geo_restrictions, :type, :policy]
  end
  module Cloudflare
    include CloudflareCustomSsl
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
