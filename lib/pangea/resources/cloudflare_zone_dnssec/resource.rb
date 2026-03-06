# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zone_dnssec/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZoneDnssec
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zone_dnssec,
      attributes_class: Cloudflare::Types::ZoneDnssecAttributes,
      outputs: { id: :id, status: :status, flags: :flags, algorithm: :algorithm, key_type: :key_type, digest_type: :digest_type, digest_algorithm: :digest_algorithm, digest: :digest, ds: :ds, key_tag: :key_tag, public_key: :public_key },
      map: [:zone_id],
      map_present: [:dnssec_presigned, :dnssec_multi_signer]
  end
  module Cloudflare
    include CloudflareZoneDnssec
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
