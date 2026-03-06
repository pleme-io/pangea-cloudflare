# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_logpush_ownership_challenge/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareLogpushOwnershipChallenge
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_logpush_ownership_challenge,
      attributes_class: Cloudflare::Types::LogpushOwnershipChallengeAttributes,
      map_present: [:zone_id, :account_id]
  end
  module Cloudflare
    include CloudflareLogpushOwnershipChallenge
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
