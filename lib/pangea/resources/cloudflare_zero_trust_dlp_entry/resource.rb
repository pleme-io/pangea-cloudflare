# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_dlp_entry/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustDlpEntry
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_dlp_entry,
      attributes_class: Cloudflare::Types::ZeroTrustDlpEntryAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustDlpEntry
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
