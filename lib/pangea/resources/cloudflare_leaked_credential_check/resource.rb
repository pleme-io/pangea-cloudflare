# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_leaked_credential_check/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareLeakedCredentialCheck
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_leaked_credential_check,
      attributes_class: Cloudflare::Types::LeakedCredentialCheckAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareLeakedCredentialCheck
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
