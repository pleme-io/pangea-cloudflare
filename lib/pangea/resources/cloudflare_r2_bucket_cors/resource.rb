# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_r2_bucket_cors/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareR2BucketCors
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_r2_bucket_cors,
      attributes_class: Cloudflare::Types::R2BucketCorsAttributes,
      map: [:account_id, :bucket_name] do |r, attrs|
      if attrs.rules.any?
        r.rules attrs.rules.map { |r| r.to_h }
      end
    end
  end
  module Cloudflare
    include CloudflareR2BucketCors
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
