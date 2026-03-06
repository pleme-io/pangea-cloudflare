# frozen_string_literal: true

# Copyright 2025 The Pangea Authors. Licensed under Apache 2.0.

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_pages_project/types'

module Pangea
  module Resources
    module CloudflarePagesProject
      include Pangea::Resources::ResourceBuilder

      define_resource :cloudflare_pages_project,
        attributes_class: Cloudflare::Types::PagesProjectAttributes,
        outputs: { id: :id, subdomain: :subdomain, domains: :domains, created_on: :created_on },
        map: [:account_id, :name],
        map_present: [:production_branch] do |r, attrs|
        if attrs.build_config
          r.build_config do
            build_command attrs.build_config.build_command if attrs.build_config.build_command
            destination_dir attrs.build_config.destination_dir if attrs.build_config.destination_dir
            root_dir attrs.build_config.root_dir if attrs.build_config.root_dir
            build_caching attrs.build_config.build_caching if attrs.build_config.build_caching
            web_analytics_tag attrs.build_config.web_analytics_tag if attrs.build_config.web_analytics_tag
            web_analytics_token attrs.build_config.web_analytics_token if attrs.build_config.web_analytics_token
          end
        end

        if attrs.source
          r.source do
            type attrs.source.type
            config do
              owner attrs.source.config.owner
              repo_name attrs.source.config.repo_name
              production_branch attrs.source.config.production_branch if attrs.source.config.production_branch
              production_deployments_enabled attrs.source.config.production_deployments_enabled if attrs.source.config.production_deployments_enabled
              deployments_enabled attrs.source.config.deployments_enabled if attrs.source.config.deployments_enabled
              pr_comments_enabled attrs.source.config.pr_comments_enabled if attrs.source.config.pr_comments_enabled
              preview_deployment_setting attrs.source.config.preview_deployment_setting if attrs.source.config.preview_deployment_setting
              preview_branch_includes attrs.source.config.preview_branch_includes if attrs.source.config.preview_branch_includes
              preview_branch_excludes attrs.source.config.preview_branch_excludes if attrs.source.config.preview_branch_excludes
            end
          end
        end

        if attrs.deployment_configs
          r.deployment_configs do
            if attrs.deployment_configs.production
              production { CloudflarePagesProject.synthesize_deployment_config(self, attrs.deployment_configs.production) }
            end
            if attrs.deployment_configs.preview
              preview { CloudflarePagesProject.synthesize_deployment_config(self, attrs.deployment_configs.preview) }
            end
          end
        end
      end
    end
  end
end
