# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_access_short_lived_certificate/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustAccessShortLivedCertificate
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_access_short_lived_certificate,
      attributes_class: Cloudflare::Types::ZeroTrustAccessShortLivedCertificateAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustAccessShortLivedCertificate
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
