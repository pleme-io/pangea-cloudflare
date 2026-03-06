# frozen_string_literal: true
require 'pangea/resource_registry'
require_relative 'resource/main'
require_relative 'resource/deployment_config'

module Pangea::Resources
  module Cloudflare
    include CloudflarePagesProject
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
