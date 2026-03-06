# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_custom_hostname/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareCustomHostname
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_custom_hostname,
      attributes_class: Cloudflare::Types::CustomHostnameAttributes,
      outputs: { id: :id, status: :status, ownership_verification: :ownership_verification, ownership_verification_http: :ownership_verification_http, ssl_status: 'ssl.0.status', ssl_validation_errors: 'ssl.0.validation_errors', ssl_validation_records: 'ssl.0.validation_records' },
      map: [:zone_id, :hostname],
      map_present: [:custom_origin_server, :custom_origin_sni, :wait_for_ssl_pending_validation] do |r, attrs|
      if attrs.ssl
        r.ssl do
          # method is a Kernel method, must use hash access and method_missing
          method_missing(:method, attrs.ssl[:method]) if attrs.ssl[:method]
          type attrs.ssl.type if attrs.ssl.type
          certificate_authority attrs.ssl.certificate_authority if attrs.ssl.certificate_authority
          bundle_method attrs.ssl.bundle_method if attrs.ssl.bundle_method
          wildcard attrs.ssl.wildcard if attrs.ssl.wildcard
          custom_certificate attrs.ssl.custom_certificate if attrs.ssl.custom_certificate
          custom_key attrs.ssl.custom_key if attrs.ssl.custom_key
          # SSL settings
          if attrs.ssl.settings
            settings do
              min_tls_version attrs.ssl.settings.min_tls_version if attrs.ssl.settings.min_tls_version
              early_hints attrs.ssl.settings.early_hints if attrs.ssl.settings.early_hints
              http2 attrs.ssl.settings.http2 if attrs.ssl.settings.http2
              tls13 attrs.ssl.settings.tls13 if attrs.ssl.settings.tls13
              ciphers attrs.ssl.settings.ciphers if attrs.ssl.settings.ciphers
            end
          end
        end
      end
      if attrs.custom_metadata
        r.custom_metadata do
          attrs.custom_metadata.each do |key, value|
            send(key.to_sym, value)
          end
        end
      end
    end
  end
  module Cloudflare
    include CloudflareCustomHostname
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
