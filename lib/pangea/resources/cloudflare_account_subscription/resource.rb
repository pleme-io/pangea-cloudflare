# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_account_subscription/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareAccountSubscription
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_account_subscription,
      attributes_class: Cloudflare::Types::AccountSubscriptionAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareAccountSubscription
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
