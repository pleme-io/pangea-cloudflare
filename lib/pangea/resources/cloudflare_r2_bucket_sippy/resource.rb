# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_r2_bucket_sippy/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareR2BucketSippy
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_r2_bucket_sippy,
      attributes_class: Cloudflare::Types::R2BucketSippyAttributes,
      map: [:account_id]
  end
  module Cloudflare
    include CloudflareR2BucketSippy
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
