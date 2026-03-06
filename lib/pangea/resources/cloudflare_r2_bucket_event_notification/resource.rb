# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_r2_bucket_event_notification/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareR2BucketEventNotification
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_r2_bucket_event_notification,
      attributes_class: Cloudflare::Types::R2BucketEventNotificationAttributes,
      map: [:account_id, :bucket, :queue],
      map_present: [:event_types, :prefix, :suffix]
  end
  module Cloudflare
    include CloudflareR2BucketEventNotification
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
