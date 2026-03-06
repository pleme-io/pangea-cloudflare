# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_logpush_job/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareLogpushJob
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_logpush_job,
      attributes_class: Cloudflare::Types::LogpushJobAttributes,
      map: [:dataset, :destination_conf],
      map_present: [:zone_id, :account_id, :filter, :frequency, :kind, :logpull_options, :max_upload_bytes, :max_upload_interval_seconds, :max_upload_records, :name, :output_options, :ownership_challenge],
      map_bool: [:enabled]
  end
  module Cloudflare
    include CloudflareLogpushJob
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
