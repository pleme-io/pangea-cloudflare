# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_hyperdrive_config/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareHyperdriveConfig
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_hyperdrive_config,
      attributes_class: Cloudflare::Types::HyperdriveConfigAttributes,
      map: [:account_id, :name],
      map_present: [:origin_connection_limit] do |r, attrs|
      r.origin do
        database attrs.origin.database
        host attrs.origin.host
        user attrs.origin.user
        password attrs.origin.password
        scheme attrs.origin.scheme
        port attrs.origin.port if attrs.origin.port
        # Access configuration for private databases
        access_client_id attrs.origin.access_client_id if attrs.origin.access_client_id
        access_client_secret attrs.origin.access_client_secret if attrs.origin.access_client_secret
      end
      if attrs.caching
        r.caching do
          disabled attrs.caching.disabled if attrs.caching.disabled
          max_age attrs.caching.max_age if attrs.caching.max_age
          stale_while_revalidate attrs.caching.stale_while_revalidate if attrs.caching.stale_while_revalidate
        end
      end
      if attrs.mtls
        r.mtls do
          ca_certificate_id attrs.mtls.ca_certificate_id if attrs.mtls.ca_certificate_id
          mtls_certificate_id attrs.mtls.mtls_certificate_id if attrs.mtls.mtls_certificate_id
          sslmode attrs.mtls.sslmode if attrs.mtls.sslmode
        end
      end
    end
  end
  module Cloudflare
    include CloudflareHyperdriveConfig
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
