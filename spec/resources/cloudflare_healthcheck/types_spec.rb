# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_healthcheck/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::HealthcheckAttributes do
  let(:zone_id) { "a" * 32 }

  let(:valid_attrs) do
    { zone_id: zone_id, name: "api-health", address: "api.example.com" }
  end

  describe '#frequent_check?' do
    it 'returns true when interval is 60' do
      hc = described_class.new(valid_attrs)
      expect(hc.frequent_check?).to be true
    end

    it 'returns true when interval is 30' do
      hc = described_class.new(valid_attrs.merge(interval: 30))
      expect(hc.frequent_check?).to be true
    end

    it 'returns false when interval is 120' do
      hc = described_class.new(valid_attrs.merge(interval: 120))
      expect(hc.frequent_check?).to be false
    end
  end

  describe '#notifications_configured?' do
    it 'returns true when email addresses present' do
      hc = described_class.new(valid_attrs.merge(notification_email_addresses: ["ops@example.com"]))
      expect(hc.notifications_configured?).to be true
    end

    it 'returns false when no email addresses' do
      hc = described_class.new(valid_attrs)
      expect(hc.notifications_configured?).to be_falsey
    end
  end

  describe '#default_port' do
    it 'returns 443 for HTTPS' do
      hc = described_class.new(valid_attrs)
      expect(hc.default_port).to eq(443)
    end

    it 'returns 80 for HTTP' do
      hc = described_class.new(valid_attrs.merge(type: "HTTP"))
      expect(hc.default_port).to eq(80)
    end

    it 'returns configured port for TCP' do
      hc = described_class.new(valid_attrs.merge(type: "TCP", port: 5432))
      expect(hc.default_port).to eq(5432)
    end

    it 'returns 0 for TCP without port' do
      hc = described_class.new(valid_attrs.merge(type: "TCP"))
      expect(hc.default_port).to eq(0)
    end
  end

  describe '#http_check?' do
    it 'returns true for HTTPS' do
      hc = described_class.new(valid_attrs)
      expect(hc.http_check?).to be true
    end

    it 'returns true for HTTP' do
      hc = described_class.new(valid_attrs.merge(type: "HTTP"))
      expect(hc.http_check?).to be true
    end

    it 'returns false for TCP' do
      hc = described_class.new(valid_attrs.merge(type: "TCP"))
      expect(hc.http_check?).to be false
    end
  end
end
