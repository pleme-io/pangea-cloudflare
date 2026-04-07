# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_load_balancer/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::LoadBalancerAttributes do
  let(:zone_id) { "a" * 32 }

  let(:valid_attrs) do
    { zone_id: zone_id, name: "lb.example.com", default_pool_ids: ["pool-1", "pool-2"] }
  end

  describe 'computed properties' do
    it '#is_enabled? returns true by default' do
      lb = described_class.new(valid_attrs)
      expect(lb.is_enabled?).to be true
    end

    it '#is_enabled? returns false when disabled' do
      lb = described_class.new(valid_attrs.merge(enabled: false))
      expect(lb.is_enabled?).to be false
    end

    it '#is_proxied? returns false by default' do
      lb = described_class.new(valid_attrs)
      expect(lb.is_proxied?).to be false
    end

    it '#is_proxied? returns true when proxied' do
      lb = described_class.new(valid_attrs.merge(proxied: true))
      expect(lb.is_proxied?).to be true
    end

    it '#has_fallback_pool? returns false when nil' do
      lb = described_class.new(valid_attrs)
      expect(lb.has_fallback_pool?).to be false
    end

    it '#has_fallback_pool? returns true when set' do
      lb = described_class.new(valid_attrs.merge(fallback_pool_id: "pool-fallback"))
      expect(lb.has_fallback_pool?).to be true
    end

    it '#has_region_pools? returns false when empty' do
      lb = described_class.new(valid_attrs)
      expect(lb.has_region_pools?).to be false
    end

    it '#has_region_pools? returns true when region pools present' do
      lb = described_class.new(valid_attrs.merge(
        region_pools: [{ region: "WNAM", pool_ids: ["pool-1"] }]
      ))
      expect(lb.has_region_pools?).to be true
    end

    it '#has_pop_pools? returns false when empty' do
      lb = described_class.new(valid_attrs)
      expect(lb.has_pop_pools?).to be false
    end

    it '#has_pop_pools? returns true when pop pools present' do
      lb = described_class.new(valid_attrs.merge(
        pop_pools: [{ pop: "LAX", pool_ids: ["pool-1"] }]
      ))
      expect(lb.has_pop_pools?).to be true
    end

    it '#uses_session_affinity? returns false for none' do
      lb = described_class.new(valid_attrs)
      expect(lb.uses_session_affinity?).to be false
    end

    it '#uses_session_affinity? returns true for cookie' do
      lb = described_class.new(valid_attrs.merge(session_affinity: "cookie"))
      expect(lb.uses_session_affinity?).to be true
    end

    it '#pool_count returns number of default pools' do
      lb = described_class.new(valid_attrs)
      expect(lb.pool_count).to eq(2)
    end
  end

  describe 'validation' do
    it 'rejects empty default_pool_ids' do
      expect {
        described_class.new(valid_attrs.merge(default_pool_ids: []))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects session_affinity_ttl below 1800' do
      expect {
        described_class.new(valid_attrs.merge(session_affinity_ttl: 1799))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects session_affinity_ttl above 604800' do
      expect {
        described_class.new(valid_attrs.merge(session_affinity_ttl: 604801))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts session_affinity_ttl at minimum boundary' do
      lb = described_class.new(valid_attrs.merge(session_affinity_ttl: 1800))
      expect(lb.session_affinity_ttl).to eq(1800)
    end

    it 'accepts session_affinity_ttl at maximum boundary' do
      lb = described_class.new(valid_attrs.merge(session_affinity_ttl: 604800))
      expect(lb.session_affinity_ttl).to eq(604800)
    end
  end

  describe 'defaults' do
    let(:lb) { described_class.new(valid_attrs) }

    it 'defaults steering_policy to off' do
      expect(lb.steering_policy).to eq('off')
    end

    it 'defaults session_affinity to none' do
      expect(lb.session_affinity).to eq('none')
    end

    it 'defaults proxied to false' do
      expect(lb.proxied).to be false
    end

    it 'defaults enabled to true' do
      expect(lb.enabled).to be true
    end

    it 'defaults region_pools to empty' do
      expect(lb.region_pools).to eq([])
    end

    it 'defaults pop_pools to empty' do
      expect(lb.pop_pools).to eq([])
    end
  end
end
