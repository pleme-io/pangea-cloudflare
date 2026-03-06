# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_list_item/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareListItem
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_list_item,
      attributes_class: Cloudflare::Types::ListItemAttributes,
      outputs: { id: :id, item_id: :id },
      map: [:account_id, :list_id],
      map_present: [:ip, :asn, :comment] do |r, attrs|
      if attrs.hostname
        r.hostname do
          url_hostname attrs.hostname.url_hostname
        end
      end
      if attrs.redirect
        r.redirect do
          source_url attrs.redirect.source_url
          target_url attrs.redirect.target_url
          status_code attrs.redirect.status_code if attrs.redirect.status_code
          include_subdomains attrs.redirect.include_subdomains if attrs.redirect.include_subdomains
          preserve_path_suffix attrs.redirect.preserve_path_suffix if attrs.redirect.preserve_path_suffix
          preserve_query_string attrs.redirect.preserve_query_string if attrs.redirect.preserve_query_string
          subpath_matching attrs.redirect.subpath_matching if attrs.redirect.subpath_matching
        end
      end
    end
  end
  module Cloudflare
    include CloudflareListItem
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
