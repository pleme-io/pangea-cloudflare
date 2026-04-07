# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_load_balancer_pool/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::LoadBalancerPoolAttributes do
  let(:account_id) { "a" * 32 }

  let(:valid_attrs) do
    {
      account_id: account_id,
      name: "primary-pool",
      origins: [{ name: "origin-1", address: "192.0.2.1" }]
    }
  end

  describe 'custom validation' do
    it 'rejects minimum_origins exceeding actual origins' do
      expect {
        described_class.new(valid_attrs.merge(minimum_origins: 2))
      }.to raise_error(Dry::Struct::Error, /minimum_origins.*cannot exceed/)
    end

    it 'accepts minimum_origins equal to origins count' do
      pool = described_class.new(valid_attrs.merge(minimum_origins: 1))
      expect(pool.minimum_origins).to eq(1)
    end
  end

  describe 'computed properties' do
    it '#origin_count returns number of origins' do
      pool = described_class.new(valid_attrs.merge(
        origins: [
          { name: "origin-1", address: "192.0.2.1" },
          { name: "origin-2", address: "192.0.2.2" }
        ]
      ))
      expect(pool.origin_count).to eq(2)
    end

    it '#has_monitor? returns false when no monitor' do
      pool = described_class.new(valid_attrs)
      expect(pool.has_monitor?).to be false
    end

    it '#has_monitor? returns true when monitor set' do
      pool = described_class.new(valid_attrs.merge(monitor: "monitor-123"))
      expect(pool.has_monitor?).to be true
    end

    it '#is_enabled? returns true by default' do
      pool = described_class.new(valid_attrs)
      expect(pool.is_enabled?).to be true
    end

    it '#is_enabled? returns false when disabled' do
      pool = described_class.new(valid_attrs.merge(enabled: false))
      expect(pool.is_enabled?).to be false
    end

    it '#enabled_origin_count counts enabled origins' do
      pool = described_class.new(valid_attrs.merge(
        origins: [
          { name: "origin-1", address: "192.0.2.1", enabled: true },
          { name: "origin-2", address: "192.0.2.2", enabled: false }
        ]
      ))
      expect(pool.enabled_origin_count).to eq(1)
    end
  end
end
