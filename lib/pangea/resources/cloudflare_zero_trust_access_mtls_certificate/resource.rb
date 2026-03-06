# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_access_mtls_certificate/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustAccessMtlsCertificate
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_access_mtls_certificate,
      attributes_class: Cloudflare::Types::ZeroTrustAccessMtlsCertificateAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustAccessMtlsCertificate
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
