# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_workflow/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWorkflow
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_workflow,
      attributes_class: Cloudflare::Types::WorkflowAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareWorkflow
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
