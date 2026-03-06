# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_workers_for_platforms_dispatch_namespace/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWorkersForPlatformsDispatchNamespace
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_workers_for_platforms_dispatch_namespace,
      attributes_class: Cloudflare::Types::WorkersForPlatformsDispatchNamespaceAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareWorkersForPlatformsDispatchNamespace
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
