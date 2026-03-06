# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_dlp_dataset/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustDlpDataset
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_dlp_dataset,
      attributes_class: Cloudflare::Types::ZeroTrustDlpDatasetAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareZeroTrustDlpDataset
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
