# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_access_policy/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustAccessPolicy
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_access_policy,
      attributes_class: Cloudflare::Types::ZeroTrustAccessPolicyAttributes,
      map: [:name, :decision, :precedence],
      map_present: [:account_id, :zone_id, :application_id, :include, :exclude, :require, :approval_groups, :purpose_justification_prompt, :session_duration],
      map_bool: [:approval_required, :purpose_justification_required]
  end
  module Cloudflare
    include CloudflareZeroTrustAccessPolicy
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
