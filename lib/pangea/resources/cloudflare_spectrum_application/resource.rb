# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_spectrum_application/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareSpectrumApplication
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_spectrum_application,
      attributes_class: Cloudflare::Types::SpectrumApplicationAttributes,
      outputs: { id: :id, application_id: :id },
      map: [:zone_id, :protocol] do |r, attrs|
      r.dns do
        name attrs.dns_name
        type attrs.dns_type
      end
      if attrs.origin_direct
        r.origin_direct attrs.origin_direct
      elsif attrs.origin_dns_name
        r.origin_dns do
          name attrs.origin_dns_name
        end
        r.origin_port attrs.origin_port if attrs.origin_port
      end
      if attrs.edge_ip_connectivity || attrs.edge_ip_type
        r.edge_ips do
          connectivity attrs.edge_ip_connectivity if attrs.edge_ip_connectivity
          type attrs.edge_ip_type if attrs.edge_ip_type
        end
      end
      r.ip_firewall attrs.ip_firewall if attrs.ip_firewall
      r.proxy_protocol attrs.proxy_protocol if attrs.proxy_protocol
      r.tls attrs.tls if attrs.tls
      r.traffic_type attrs.traffic_type if attrs.traffic_type
    end
  end
  module Cloudflare
    include CloudflareSpectrumApplication
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
