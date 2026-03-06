# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_r2_bucket_lifecycle/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareR2BucketLifecycle
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_r2_bucket_lifecycle,
      attributes_class: Cloudflare::Types::R2BucketLifecycleAttributes,
      map: [:account_id, :bucket_name] do |r, attrs|
      if attrs.rules.any?
        r.rules attrs.rules.map { |r| r.to_h }
      end
    end
  end
  module Cloudflare
    include CloudflareR2BucketLifecycle
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
