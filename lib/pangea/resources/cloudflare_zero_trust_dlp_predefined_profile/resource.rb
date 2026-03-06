# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_dlp_predefined_profile/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustDlpPredefinedProfile
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_dlp_predefined_profile,
      attributes_class: Cloudflare::Types::ZeroTrustDlpPredefinedProfileAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustDlpPredefinedProfile
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
