# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_dlp_custom_profile/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustDlpCustomProfile
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_dlp_custom_profile,
      attributes_class: Cloudflare::Types::ZeroTrustDlpCustomProfileAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustDlpCustomProfile
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
