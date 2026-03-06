# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_queue/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareQueue
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_queue,
      attributes_class: Cloudflare::Types::QueueAttributes,
      outputs: { id: :id, queue_id: :id, queue_name: :name },
      map: [:account_id],
      map_present: [:max_concurrency, :max_retries, :max_wait_time_ms, :retry_delay, :visibility_timeout_ms, :message_retention_period] do |r, attrs|
      r.name attrs.queue_name
    end
  end
  module Cloudflare
    include CloudflareQueue
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
