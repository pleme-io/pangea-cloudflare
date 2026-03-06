# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_leaked_credential_check_rule/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareLeakedCredentialCheckRule
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_leaked_credential_check_rule,
      attributes_class: Cloudflare::Types::LeakedCredentialCheckRuleAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareLeakedCredentialCheckRule
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
