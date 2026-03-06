# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_dlp_predefined_entry/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustDlpPredefinedEntry
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_dlp_predefined_entry,
      attributes_class: Cloudflare::Types::ZeroTrustDlpPredefinedEntryAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustDlpPredefinedEntry
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
