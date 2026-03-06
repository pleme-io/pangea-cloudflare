# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_healthcheck/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareHealthcheck
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_healthcheck,
      attributes_class: Cloudflare::Types::HealthcheckAttributes,
      outputs: { id: :id, healthcheck_id: :id, status: :status, failure_reason: :failure_reason },
      map: [:zone_id, :name, :address, :type],
      map_present: [:interval, :timeout, :retries, :consecutive_fails, :consecutive_successes, :check_regions, :notification_suspended, :notification_email_addresses, :description, :path, :port, :expected_codes, :expected_body, :follow_redirects, :allow_insecure] do |r, attrs|
      r.method_missing(:method, attrs[:method]) if attrs[:method]
    end
  end
  module Cloudflare
    include CloudflareHealthcheck
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
