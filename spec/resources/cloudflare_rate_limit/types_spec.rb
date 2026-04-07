# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_rate_limit/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::RateLimitAttributes do
  let(:zone_id) { "a" * 32 }

  let(:valid_attrs) do
    { zone_id: zone_id, threshold: 100, period: 60, action_mode: "ban" }
  end

  describe '#method_filtered?' do
    it 'returns true when methods are specified' do
      rl = described_class.new(valid_attrs.merge(match_request_methods: ["GET", "POST"]))
      expect(rl.method_filtered?).to be true
    end

    it 'returns false when no methods specified' do
      rl = described_class.new(valid_attrs)
      expect(rl.method_filtered?).to be_falsey
    end
  end

  describe '#error_only?' do
    it 'returns true when all status codes are errors' do
      rl = described_class.new(valid_attrs.merge(match_response_status: [500, 502, 503]))
      expect(rl.error_only?).to be true
    end

    it 'returns false when status codes include success' do
      rl = described_class.new(valid_attrs.merge(match_response_status: [200, 500]))
      expect(rl.error_only?).to be false
    end

    it 'returns false when no status codes specified' do
      rl = described_class.new(valid_attrs)
      expect(rl.error_only?).to be false
    end
  end

  describe '#requests_per_second' do
    it 'calculates rate correctly' do
      rl = described_class.new(valid_attrs)
      expect(rl.requests_per_second).to be_within(0.01).of(1.67)
    end

    it 'handles 1-second period' do
      rl = described_class.new(valid_attrs.merge(threshold: 10, period: 1))
      expect(rl.requests_per_second).to eq(10.0)
    end
  end

  describe '#strict?' do
    it 'returns true for period under 60 seconds' do
      rl = described_class.new(valid_attrs.merge(period: 30))
      expect(rl.strict?).to be true
    end

    it 'returns false for period of 60 seconds' do
      rl = described_class.new(valid_attrs)
      expect(rl.strict?).to be false
    end
  end
end
