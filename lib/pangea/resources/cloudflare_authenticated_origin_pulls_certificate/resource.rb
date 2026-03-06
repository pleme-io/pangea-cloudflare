# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_authenticated_origin_pulls_certificate/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareAuthenticatedOriginPullsCertificate
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_authenticated_origin_pulls_certificate,
      attributes_class: Cloudflare::Types::AuthenticatedOriginPullsCertificateAttributes,
      outputs: { id: :id, status: :status, expires_on: :expires_on },
      map: [:zone_id, :certificate, :private_key],
      map_present: [:type]
  end
  module Cloudflare
    include CloudflareAuthenticatedOriginPullsCertificate
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
