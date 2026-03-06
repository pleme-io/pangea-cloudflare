# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_worker_route/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWorkerRoute
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_worker_route,
      attributes_class: Cloudflare::Types::WorkerRouteAttributes,
      map: [:zone_id, :pattern],
      map_present: [:script_name]
  end
  module Cloudflare
    include CloudflareWorkerRoute
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
