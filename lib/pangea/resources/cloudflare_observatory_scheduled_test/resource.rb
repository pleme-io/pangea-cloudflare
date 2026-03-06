# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_observatory_scheduled_test/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareObservatoryScheduledTest
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_observatory_scheduled_test,
      attributes_class: Cloudflare::Types::ObservatoryScheduledTestAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareObservatoryScheduledTest
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
