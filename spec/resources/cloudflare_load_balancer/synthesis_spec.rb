# frozen_string_literal: true
require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/cloudflare_load_balancer/resource'
require 'pangea/resources/cloudflare_load_balancer/types'

RSpec.describe 'cloudflare_load_balancer synthesis' do
  include Pangea::Resources::Cloudflare

  let(:synthesizer) { TerraformSynthesizer.new }
  let(:zone_id) { "0da42c8d2132a9ddaf714f9e7c920711" }

  describe 'terraform synthesis' do
    it 'synthesizes basic load balancer' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_load_balancer(:test, {
          zone_id: "0da42c8d2132a9ddaf714f9e7c920711",
          name: "lb.example.com",
          default_pool_ids: ["pool1", "pool2"]
        })
      end

      result = synthesizer.synthesis
      lb = result[:resource][:cloudflare_load_balancer][:test]

      expect(lb[:zone_id]).to eq(zone_id)
      expect(lb[:name]).to eq("lb.example.com")
      expect(lb[:default_pool_ids]).to eq(["pool1", "pool2"])
      expect(lb[:steering_policy]).to eq("off")
      expect(lb[:session_affinity]).to eq("none")
      expect(lb[:enabled]).to be true
    end

    it 'synthesizes load balancer with fallback pool and description' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_load_balancer(:with_fallback, {
          zone_id: "0da42c8d2132a9ddaf714f9e7c920711",
          name: "lb.example.com",
          default_pool_ids: ["pool1"],
          fallback_pool_id: "pool-fallback",
          description: "Production load balancer",
          steering_policy: "geo",
          session_affinity: "cookie"
        })
      end

      result = synthesizer.synthesis
      lb = result[:resource][:cloudflare_load_balancer][:with_fallback]

      expect(lb[:fallback_pool_id]).to eq("pool-fallback")
      expect(lb[:description]).to eq("Production load balancer")
      expect(lb[:steering_policy]).to eq("geo")
      expect(lb[:session_affinity]).to eq("cookie")
    end

    it 'synthesizes load balancer with region pools' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_load_balancer(:geo_lb, {
          zone_id: "0da42c8d2132a9ddaf714f9e7c920711",
          name: "geo-lb.example.com",
          default_pool_ids: ["pool1"],
          steering_policy: "geo",
          region_pools: [
            { region: "WNAM", pool_ids: ["pool-us-west"] },
            { region: "WEU", pool_ids: ["pool-eu-west"] }
          ]
        })
      end

      result = synthesizer.synthesis
      lb = result[:resource][:cloudflare_load_balancer][:geo_lb]

      expect(lb[:steering_policy]).to eq("geo")
    end

    it 'synthesizes load balancer with pop pools' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_load_balancer(:pop_lb, {
          zone_id: "0da42c8d2132a9ddaf714f9e7c920711",
          name: "pop-lb.example.com",
          default_pool_ids: ["pool1"],
          pop_pools: [
            { pop: "LAX", pool_ids: ["pool-lax"] }
          ]
        })
      end

      result = synthesizer.synthesis
      lb = result[:resource][:cloudflare_load_balancer][:pop_lb]

      expect(lb).to be_a(Hash)
      expect(lb[:name]).to eq("pop-lb.example.com")
    end

    it 'synthesizes disabled load balancer' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_load_balancer(:disabled, {
          zone_id: "0da42c8d2132a9ddaf714f9e7c920711",
          name: "disabled-lb.example.com",
          default_pool_ids: ["pool1"],
          enabled: false,
          proxied: true
        })
      end

      result = synthesizer.synthesis
      lb = result[:resource][:cloudflare_load_balancer][:disabled]

      expect(lb[:enabled]).to be false
      expect(lb[:proxied]).to be true
    end
  end

  describe 'resource references' do
    it 'provides correct terraform interpolation strings' do
      ref = synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_load_balancer(:test, {
          zone_id: "0da42c8d2132a9ddaf714f9e7c920711",
          name: "lb.example.com",
          default_pool_ids: ["pool1"]
        })
      end

      expect(ref.id).to eq("${cloudflare_load_balancer.test.id}")
      expect(ref.outputs[:created_on]).to eq("${cloudflare_load_balancer.test.created_on}")
      expect(ref.outputs[:modified_on]).to eq("${cloudflare_load_balancer.test.modified_on}")
    end
  end
end
