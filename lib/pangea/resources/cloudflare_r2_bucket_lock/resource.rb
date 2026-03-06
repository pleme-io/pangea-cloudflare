# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_r2_bucket_lock/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareR2BucketLock
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_r2_bucket_lock,
      attributes_class: Cloudflare::Types::R2BucketLockAttributes,
      map: [:account_id, :bucket_name, :enabled],
      map_present: [:retention_period_days]
  end
  module Cloudflare
    include CloudflareR2BucketLock
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
