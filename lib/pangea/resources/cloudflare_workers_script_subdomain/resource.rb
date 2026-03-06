# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_workers_script_subdomain/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWorkersScriptSubdomain
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_workers_script_subdomain,
      attributes_class: Cloudflare::Types::WorkersScriptSubdomainAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareWorkersScriptSubdomain
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
