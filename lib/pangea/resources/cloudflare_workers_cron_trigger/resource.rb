# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_workers_cron_trigger/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareWorkersCronTrigger
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_workers_cron_trigger,
      attributes_class: Cloudflare::Types::WorkersCronTriggerAttributes,
      outputs: { id: :id, trigger_id: :id },
      map: [:account_id, :script_name, :schedules]
  end
  module Cloudflare
    include CloudflareWorkersCronTrigger
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
