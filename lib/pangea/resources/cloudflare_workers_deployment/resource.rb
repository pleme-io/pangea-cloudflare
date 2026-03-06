# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_workers_deployment/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWorkersDeployment
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_workers_deployment,
      attributes_class: Cloudflare::Types::WorkersDeploymentAttributes,
      map: [:account_id, :script_name],
      map_present: [:version_id]
  end
  module Cloudflare
    include CloudflareWorkersDeployment
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
