# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_account_member/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareAccountMember
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_account_member,
      attributes_class: Cloudflare::Types::AccountMemberAttributes,
      map: [:account_id, :email_address, :role_ids],
      map_present: [:status]
  end
  module Cloudflare
    include CloudflareAccountMember
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
