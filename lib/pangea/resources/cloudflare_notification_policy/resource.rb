# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_notification_policy/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareNotificationPolicy
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_notification_policy,
      attributes_class: Cloudflare::Types::NotificationPolicyAttributes,
      map: [:account_id, :name, :alert_type, :enabled],
      map_present: [:description, :email_integration, :webhooks_integration, :pagerduty_integration, :filters]
  end
  module Cloudflare
    include CloudflareNotificationPolicy
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
