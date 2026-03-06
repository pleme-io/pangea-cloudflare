# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_keyless_certificate/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareKeylessCertificate
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_keyless_certificate,
      attributes_class: Cloudflare::Types::KeylessCertificateAttributes,
      map: [:zone_id]
  end
  module Cloudflare
    include CloudflareKeylessCertificate
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
