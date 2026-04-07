# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_record/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::RecordAttributes do
  let(:zone_id) { "a" * 32 }

  let(:valid_a_record) do
    { zone_id: zone_id, name: "www", type: "A", value: "192.0.2.1" }
  end

  describe 'custom validation' do
    it 'rejects MX record without priority' do
      expect {
        described_class.new(zone_id: zone_id, name: "@", type: "MX", value: "mail.example.com")
      }.to raise_error(Dry::Struct::Error, /MX records require a priority/)
    end

    it 'accepts MX record with priority' do
      record = described_class.new(
        zone_id: zone_id, name: "@", type: "MX", value: "mail.example.com", priority: 10
      )
      expect(record.type).to eq("MX")
      expect(record.priority).to eq(10)
    end

    it 'rejects SRV record without data' do
      expect {
        described_class.new(zone_id: zone_id, name: "_sip._tcp", type: "SRV", value: "sip.example.com")
      }.to raise_error(Dry::Struct::Error, /SRV records require data/)
    end

    it 'rejects proxied on non-A/AAAA/CNAME record' do
      expect {
        described_class.new(zone_id: zone_id, name: "@", type: "TXT", value: "test", proxied: true)
      }.to raise_error(Dry::Struct::Error, /Proxied.*can only be used with A, AAAA, and CNAME/)
    end

    it 'rejects proxied record with non-automatic TTL' do
      expect {
        described_class.new(zone_id: zone_id, name: "www", type: "A", value: "192.0.2.1", proxied: true, ttl: 3600)
      }.to raise_error(Dry::Struct::Error, /Proxied records must use TTL=1/)
    end

    it 'accepts proxied record with TTL=1' do
      record = described_class.new(
        zone_id: zone_id, name: "www", type: "A", value: "192.0.2.1", proxied: true, ttl: 1
      )
      expect(record.proxied).to be true
      expect(record.ttl).to eq(1)
    end
  end

  describe 'computed properties' do
    let(:a_record) { described_class.new(valid_a_record) }

    it '#can_be_proxied? returns true for A records' do
      expect(a_record.can_be_proxied?).to be true
    end

    it '#can_be_proxied? returns true for AAAA records' do
      record = described_class.new(valid_a_record.merge(type: "AAAA", value: "2001:db8::1"))
      expect(record.can_be_proxied?).to be true
    end

    it '#can_be_proxied? returns true for CNAME records' do
      record = described_class.new(valid_a_record.merge(type: "CNAME", value: "example.com"))
      expect(record.can_be_proxied?).to be true
    end

    it '#can_be_proxied? returns false for MX records' do
      record = described_class.new(valid_a_record.merge(type: "MX", value: "mail.example.com", priority: 10))
      expect(record.can_be_proxied?).to be false
    end

    it '#requires_priority? returns true for MX records' do
      record = described_class.new(valid_a_record.merge(type: "MX", value: "mail.example.com", priority: 10))
      expect(record.requires_priority?).to be true
    end

    it '#requires_priority? returns false for A records' do
      expect(a_record.requires_priority?).to be false
    end

    it '#is_root_domain? returns true when name is @' do
      record = described_class.new(valid_a_record.merge(name: "@"))
      expect(record.is_root_domain?).to be true
    end

    it '#is_root_domain? returns false for subdomain' do
      expect(a_record.is_root_domain?).to be false
    end

    it '#is_txt_record? returns true for TXT type' do
      record = described_class.new(valid_a_record.merge(type: "TXT", value: "v=spf1"))
      expect(record.is_txt_record?).to be true
    end

    it '#is_txt_record? returns false for A type' do
      expect(a_record.is_txt_record?).to be false
    end

    it '#is_mx_record? returns true for MX type' do
      record = described_class.new(valid_a_record.merge(type: "MX", value: "mail.example.com", priority: 10))
      expect(record.is_mx_record?).to be true
    end

    it '#is_caa_record? returns true for CAA type' do
      record = described_class.new(valid_a_record.merge(type: "CAA", value: "letsencrypt.org"))
      expect(record.is_caa_record?).to be true
    end
  end

  describe 'default values' do
    it 'defaults TTL to 1 (automatic)' do
      record = described_class.new(valid_a_record)
      expect(record.ttl).to eq(1)
    end

    it 'defaults proxied to false' do
      record = described_class.new(valid_a_record)
      expect(record.proxied).to be false
    end

    it 'defaults tags to empty hash' do
      record = described_class.new(valid_a_record)
      expect(record.tags).to eq({})
    end

    it 'defaults priority to nil' do
      record = described_class.new(valid_a_record)
      expect(record.priority).to be_nil
    end

    it 'defaults data to nil' do
      record = described_class.new(valid_a_record)
      expect(record.data).to be_nil
    end

    it 'defaults comment to nil' do
      record = described_class.new(valid_a_record)
      expect(record.comment).to be_nil
    end
  end
end
