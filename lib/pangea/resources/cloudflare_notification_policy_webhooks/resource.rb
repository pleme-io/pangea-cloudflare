# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_notification_policy_webhooks/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareNotificationPolicyWebhooks
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_notification_policy_webhooks,
      attributes_class: Cloudflare::Types::NotificationPolicyWebhooksAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareNotificationPolicyWebhooks
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
