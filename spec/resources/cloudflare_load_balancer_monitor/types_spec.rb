# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_load_balancer_monitor/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::LoadBalancerMonitorAttributes do
  let(:account_id) { "a" * 32 }

  let(:valid_attrs) do
    { account_id: account_id }
  end

  describe 'computed properties' do
    it '#is_http_monitor? returns true for http' do
      monitor = described_class.new(valid_attrs)
      expect(monitor.is_http_monitor?).to be true
    end

    it '#is_http_monitor? returns true for https' do
      monitor = described_class.new(valid_attrs.merge(type: "https"))
      expect(monitor.is_http_monitor?).to be true
    end

    it '#is_http_monitor? returns false for tcp' do
      monitor = described_class.new(valid_attrs.merge(type: "tcp"))
      expect(monitor.is_http_monitor?).to be false
    end

    it '#is_tcp_monitor? returns true for tcp' do
      monitor = described_class.new(valid_attrs.merge(type: "tcp"))
      expect(monitor.is_tcp_monitor?).to be true
    end

    it '#timeout_in_ms converts seconds to ms' do
      monitor = described_class.new(valid_attrs)
      expect(monitor.timeout_in_ms).to eq(5000)
    end

    it '#has_custom_headers? returns false by default' do
      monitor = described_class.new(valid_attrs)
      expect(monitor.has_custom_headers?).to be false
    end

    it '#has_custom_headers? returns true when headers set' do
      monitor = described_class.new(valid_attrs.merge(header: { "Host" => ["example.com"] }))
      expect(monitor.has_custom_headers?).to be true
    end
  end

  describe 'defaults' do
    let(:monitor) { described_class.new(valid_attrs) }

    it 'defaults type to http' do
      expect(monitor.type).to eq("http")
    end

    it 'defaults expected_codes to 200' do
      expect(monitor.expected_codes).to eq("200")
    end

    it 'defaults method to GET' do
      expect(monitor.attributes[:method]).to eq("GET")
    end

    it 'defaults timeout to 5' do
      expect(monitor.timeout).to eq(5)
    end

    it 'defaults path to /' do
      expect(monitor.path).to eq("/")
    end

    it 'defaults interval to 60' do
      expect(monitor.interval).to eq(60)
    end

    it 'defaults retries to 2' do
      expect(monitor.retries).to eq(2)
    end

    it 'defaults allow_insecure to false' do
      expect(monitor.allow_insecure).to be false
    end

    it 'defaults follow_redirects to false' do
      expect(monitor.follow_redirects).to be false
    end
  end
end
