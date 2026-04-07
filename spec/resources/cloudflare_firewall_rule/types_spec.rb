# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_firewall_rule/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::FirewallRuleAttributes do
  let(:zone_id) { "a" * 32 }

  let(:valid_attrs) do
    { zone_id: zone_id, filter_id: "filter-123", action: "block" }
  end

  describe 'computed properties' do
    it '#is_active? returns true when not paused' do
      rule = described_class.new(valid_attrs)
      expect(rule.is_active?).to be true
    end

    it '#is_active? returns false when paused' do
      rule = described_class.new(valid_attrs.merge(paused: true))
      expect(rule.is_active?).to be false
    end

    it '#is_blocking? returns true for block action' do
      rule = described_class.new(valid_attrs)
      expect(rule.is_blocking?).to be true
    end

    it '#is_blocking? returns false for allow action' do
      rule = described_class.new(valid_attrs.merge(action: "allow"))
      expect(rule.is_blocking?).to be false
    end

    it '#is_allowing? returns true for allow action' do
      rule = described_class.new(valid_attrs.merge(action: "allow"))
      expect(rule.is_allowing?).to be true
    end

    it '#is_challenging? returns true for challenge action' do
      rule = described_class.new(valid_attrs.merge(action: "challenge"))
      expect(rule.is_challenging?).to be true
    end

    it '#is_challenging? returns true for js_challenge action' do
      rule = described_class.new(valid_attrs.merge(action: "js_challenge"))
      expect(rule.is_challenging?).to be true
    end

    it '#is_challenging? returns true for managed_challenge action' do
      rule = described_class.new(valid_attrs.merge(action: "managed_challenge"))
      expect(rule.is_challenging?).to be true
    end

    it '#is_challenging? returns false for block action' do
      rule = described_class.new(valid_attrs)
      expect(rule.is_challenging?).to be false
    end

    it '#is_logging_only? returns true for log action' do
      rule = described_class.new(valid_attrs.merge(action: "log"))
      expect(rule.is_logging_only?).to be true
    end

    it '#is_logging_only? returns false for block action' do
      rule = described_class.new(valid_attrs)
      expect(rule.is_logging_only?).to be false
    end

    it '#bypasses_products? returns true for bypass action with products' do
      rule = described_class.new(valid_attrs.merge(action: "bypass", products: ["waf"]))
      expect(rule.bypasses_products?).to be true
    end

    it '#bypasses_products? returns false for bypass action without products' do
      rule = described_class.new(valid_attrs.merge(action: "bypass"))
      expect(rule.bypasses_products?).to be false
    end
  end
end
