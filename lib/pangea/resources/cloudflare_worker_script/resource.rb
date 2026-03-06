# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_worker_script/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWorkerScript
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_worker_script,
      attributes_class: Cloudflare::Types::WorkerScriptAttributes,
      map: [:account_id, :name, :content],
      map_present: [:compatibility_date] do |r, attrs|
      r.__send__(:module, attrs.module) if attrs.module
      if attrs.compatibility_flags.any?
        r.compatibility_flags attrs.compatibility_flags
      end
      if attrs.kv_namespace_bindings.any?
        r.kv_namespace_binding attrs.kv_namespace_bindings.map { |b| b.to_h }
      end
      if attrs.plain_text_bindings.any?
        r.plain_text_binding attrs.plain_text_bindings.map { |b| b.to_h }
      end
      if attrs.secret_text_bindings.any?
        r.secret_text_binding attrs.secret_text_bindings.map { |b| b.to_h }
      end
      if attrs.d1_database_bindings.any?
        r.d1_database_binding attrs.d1_database_bindings.map { |b| b.to_h }
      end
      if attrs.queue_bindings.any?
        r.queue_binding attrs.queue_bindings.map { |b| b.to_h }
      end
    end
  end
  module Cloudflare
    include CloudflareWorkerScript
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
