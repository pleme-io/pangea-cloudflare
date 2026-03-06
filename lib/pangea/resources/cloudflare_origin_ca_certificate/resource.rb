# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_origin_ca_certificate/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareOriginCACertificate
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_origin_ca_certificate,
      attributes_class: Cloudflare::Types::OriginCACertificateAttributes,
      outputs: { id: :id, certificate: :certificate, expires_on: :expires_on },
      map: [:csr, :hostnames, :request_type, :requested_validity]
  end
  module Cloudflare
    include CloudflareOriginCACertificate
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
