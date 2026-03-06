# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_zero_trust_access_application/types'
require 'pangea/resources/cloudflare_zero_trust_access_application/block_builders'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareZeroTrustAccessApplication
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_zero_trust_access_application,
      attributes_class: Cloudflare::Types::ZeroTrustAccessApplicationAttributes,
      outputs: { id: :id, aud: :aud },
      map: [:account_id, :name],
      map_present: [:type, :domain, :zone_id, :session_duration, :auto_redirect_to_identity, :allow_authenticate_via_warp, :allow_iframe, :service_auth_401_redirect, :enable_binding_cookie, :http_only_cookie_attribute, :same_site_cookie_attribute, :path_cookie_attribute, :skip_interstitial, :app_launcher_visible, :app_launcher_logo_url, :logo_url, :skip_app_launcher_login_page, :bg_color, :header_bg_color, :custom_deny_message, :custom_deny_url, :custom_non_identity_deny_url, :custom_pages, :options_preflight_bypass, :allowed_idps, :tags, :self_hosted_domains] do |r, attrs|
      r.extend Pangea::Resources::CloudflareZeroTrustAccessApplication::BlockBuilders
      r.build_cors_headers(attrs.cors_headers) if attrs.cors_headers
      attrs.destinations&.each { |dest| r.build_destination(dest) }
      r.build_landing_page_design(attrs.landing_page_design) if attrs.landing_page_design
      attrs.footer_links&.each { |link| r.build_footer_link(link) }
      r.build_saas_app(attrs.saas_app) if attrs.saas_app
      r.build_scim_config(attrs.scim_config) if attrs.scim_config
    end
  end
  module Cloudflare
    include CloudflareZeroTrustAccessApplication
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
