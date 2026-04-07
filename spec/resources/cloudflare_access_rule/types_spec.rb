# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_access_rule/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::AccessRuleAttributes do
  let(:zone_id) { "a" * 32 }
  let(:account_id) { "b" * 32 }

  describe 'custom validation' do
    it 'rejects when both zone_id and account_id are set' do
      expect {
        described_class.new(zone_id: zone_id, account_id: account_id, mode: "block", target: "ip", value: "192.0.2.1")
      }.to raise_error(Dry::Struct::Error, /mutually exclusive/)
    end

    it 'rejects when neither zone_id nor account_id is set' do
      expect {
        described_class.new(mode: "block", target: "ip", value: "192.0.2.1")
      }.to raise_error(Dry::Struct::Error, /must be provided/)
    end

    it 'accepts zone-level rule' do
      rule = described_class.new(zone_id: zone_id, mode: "block", target: "ip", value: "192.0.2.1")
      expect(rule.zone_id).to eq(zone_id)
    end

    it 'accepts account-level rule' do
      rule = described_class.new(account_id: account_id, mode: "block", target: "ip", value: "192.0.2.1")
      expect(rule.account_id).to eq(account_id)
    end
  end

  describe 'computed properties' do
    it '#account_level? returns true for account-level rule' do
      rule = described_class.new(account_id: account_id, mode: "block", target: "ip", value: "192.0.2.1")
      expect(rule.account_level?).to be true
    end

    it '#account_level? returns false for zone-level rule' do
      rule = described_class.new(zone_id: zone_id, mode: "block", target: "ip", value: "192.0.2.1")
      expect(rule.account_level?).to be false
    end

    it '#blocking? returns true for block mode' do
      rule = described_class.new(zone_id: zone_id, mode: "block", target: "ip", value: "192.0.2.1")
      expect(rule.blocking?).to be true
    end

    it '#blocking? returns false for whitelist mode' do
      rule = described_class.new(zone_id: zone_id, mode: "whitelist", target: "ip", value: "192.0.2.1")
      expect(rule.blocking?).to be false
    end

    it '#whitelist? returns true for whitelist mode' do
      rule = described_class.new(zone_id: zone_id, mode: "whitelist", target: "ip", value: "192.0.2.1")
      expect(rule.whitelist?).to be true
    end
  end
end
