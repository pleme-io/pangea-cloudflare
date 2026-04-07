# frozen_string_literal: true
require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/cloudflare_zone_settings_override/resource'
require 'pangea/resources/cloudflare_zone_settings_override/types'

RSpec.describe 'cloudflare_zone_settings_override synthesis' do
  include Pangea::Resources::Cloudflare

  let(:synthesizer) { TerraformSynthesizer.new }
  let(:zone_id) { "0da42c8d2132a9ddaf714f9e7c920711" }

  describe 'terraform synthesis' do
    it 'synthesizes without settings' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_zone_settings_override(:test, { zone_id: "0da42c8d2132a9ddaf714f9e7c920711" })
      end

      result = synthesizer.synthesis
      override = result[:resource][:cloudflare_zone_settings_override][:test]

      expect(override[:zone_id]).to eq(zone_id)
    end

    it 'synthesizes with flat settings' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_zone_settings_override(:secure, {
          zone_id: "0da42c8d2132a9ddaf714f9e7c920711",
          settings: {
            ssl: "strict",
            always_use_https: "on",
            security_level: "high"
          }
        })
      end

      result = synthesizer.synthesis
      override = result[:resource][:cloudflare_zone_settings_override][:secure]

      expect(override[:zone_id]).to eq(zone_id)
      expect(override[:settings][:ssl]).to eq("strict")
      expect(override[:settings][:always_use_https]).to eq("on")
      expect(override[:settings][:security_level]).to eq("high")
    end

    it 'synthesizes with nested hash settings' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_zone_settings_override(:with_minify, {
          zone_id: "0da42c8d2132a9ddaf714f9e7c920711",
          settings: {
            minify: {
              css: "on",
              js: "on",
              html: "on"
            }
          }
        })
      end

      result = synthesizer.synthesis
      override = result[:resource][:cloudflare_zone_settings_override][:with_minify]

      expect(override[:settings][:minify][:css]).to eq("on")
      expect(override[:settings][:minify][:js]).to eq("on")
    end
  end

  describe 'resource references' do
    it 'provides correct terraform interpolation strings' do
      ref = synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_zone_settings_override(:test, { zone_id: "0da42c8d2132a9ddaf714f9e7c920711" })
      end

      expect(ref.id).to eq("${cloudflare_zone_settings_override.test.id}")
    end
  end
end
