# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_email_security_block_sender/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareEmailSecurityBlockSender
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_email_security_block_sender,
      attributes_class: Cloudflare::Types::EmailSecurityBlockSenderAttributes,
      map_present: [:account_id, :zone_id]
  end
  module Cloudflare
    include CloudflareEmailSecurityBlockSender
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
