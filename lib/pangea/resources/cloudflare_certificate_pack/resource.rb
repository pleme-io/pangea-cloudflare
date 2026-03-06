# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_certificate_pack/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareCertificatePack
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_certificate_pack,
      attributes_class: Cloudflare::Types::CertificatePackAttributes,
      map: [:zone_id]
  end
  module Cloudflare
    include CloudflareCertificatePack
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
