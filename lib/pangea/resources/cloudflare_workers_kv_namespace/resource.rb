# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_workers_kv_namespace/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWorkersKvNamespace
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_workers_kv_namespace,
      attributes_class: Cloudflare::Types::WorkersKvNamespaceAttributes,
      outputs: { id: :id, namespace_id: :id },
      map: [:account_id, :title]
  end
  module Cloudflare
    include CloudflareWorkersKvNamespace
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
