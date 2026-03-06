# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_email_security_impersonation_registry/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareEmailSecurityImpersonationRegistry
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_email_security_impersonation_registry,
      attributes_class: Cloudflare::Types::EmailSecurityImpersonationRegistryAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareEmailSecurityImpersonationRegistry
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
