# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_queue_consumer/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareQueueConsumer
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_queue_consumer,
      attributes_class: Cloudflare::Types::QueueConsumerAttributes,
      map: [:account_id, :queue_id, :script_name],
      map_present: [:batch_size, :max_retries, :max_wait_time_ms]
  end
  module Cloudflare
    include CloudflareQueueConsumer
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
