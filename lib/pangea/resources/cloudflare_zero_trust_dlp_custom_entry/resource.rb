# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_dlp_custom_entry/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustDlpCustomEntry
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_dlp_custom_entry,
      attributes_class: Cloudflare::Types::ZeroTrustDlpCustomEntryAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustDlpCustomEntry
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
