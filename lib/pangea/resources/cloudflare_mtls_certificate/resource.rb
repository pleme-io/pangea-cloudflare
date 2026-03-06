# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_mtls_certificate/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareMtlsCertificate
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_mtls_certificate,
      attributes_class: Cloudflare::Types::MtlsCertificateAttributes,
      outputs: { id: :id, expires_on: :expires_on, issuer: :issuer },
      map: [:account_id, :ca, :certificates],
      map_present: [:name, :private_key]
  end
  module Cloudflare
    include CloudflareMtlsCertificate
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
