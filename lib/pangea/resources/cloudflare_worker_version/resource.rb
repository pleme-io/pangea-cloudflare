# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_worker_version/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWorkerVersion
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_worker_version,
      attributes_class: Cloudflare::Types::WorkerVersionAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareWorkerVersion
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
