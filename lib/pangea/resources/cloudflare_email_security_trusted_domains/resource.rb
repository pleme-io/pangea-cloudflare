# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_email_security_trusted_domains/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareEmailSecurityTrustedDomains
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_email_security_trusted_domains,
      attributes_class: Cloudflare::Types::EmailSecurityTrustedDomainsAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareEmailSecurityTrustedDomains
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
