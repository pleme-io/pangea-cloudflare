# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zone_settings_override/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZoneSettingsOverride
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zone_settings_override,
      attributes_class: Cloudflare::Types::ZoneSettingsOverrideAttributes,
      outputs: { id: :id, initial_settings: :initial_settings, initial_settings_read_at: :initial_settings_read_at, readonly_settings: :readonly_settings },
      map: [:zone_id] do |r, attrs|
      if attrs.settings
        r.settings do
          attrs.settings.each do |setting_name, setting_value|
            if setting_value.is_a?(Hash)
              public_send(setting_name) do
                setting_value.each do |k, v|
                  public_send(k, v)
                end
              end
            else
              public_send(setting_name, setting_value)
            end
          end
        end
      end
    end
  end
  module Cloudflare
    include CloudflareZoneSettingsOverride
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
