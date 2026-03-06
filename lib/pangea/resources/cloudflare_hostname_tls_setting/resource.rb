# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_hostname_tls_setting/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareHostnameTlsSetting
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_hostname_tls_setting,
      attributes_class: Cloudflare::Types::HostnameTlsSettingAttributes,
      map: [:zone_id]
  end
  module Cloudflare
    include CloudflareHostnameTlsSetting
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
