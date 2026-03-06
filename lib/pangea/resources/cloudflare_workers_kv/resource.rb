# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_workers_kv/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWorkersKv
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_workers_kv,
      attributes_class: Cloudflare::Types::WorkersKvAttributes,
      outputs: { id: :id, key: :key, value: :value },
      map: [:account_id, :namespace_id, :value],
      map_present: [:metadata] do |r, attrs|
      r.key attrs.key_name
    end
  end
  module Cloudflare
    include CloudflareWorkersKv
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
