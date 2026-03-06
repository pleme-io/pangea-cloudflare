# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_worker/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWorker
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_worker,
      attributes_class: Cloudflare::Types::WorkerAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareWorker
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
