# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_r2_bucket/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareR2Bucket
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_r2_bucket,
      attributes_class: Cloudflare::Types::R2BucketAttributes,
      outputs: { id: :id, bucket_name: :name, location: :location },
      map: [:account_id, :name],
      map_present: [:location]
  end
  module Cloudflare
    include CloudflareR2Bucket
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
