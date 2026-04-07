# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_page_rule/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::PageRuleAttributes do
  let(:zone_id) { "a" * 32 }

  let(:valid_attrs) do
    { zone_id: zone_id, target: "example.com/*", actions: { always_use_https: "on" } }
  end

  describe 'custom validation' do
    it 'rejects empty actions' do
      expect {
        described_class.new(valid_attrs.merge(actions: {}))
      }.to raise_error(Dry::Struct::Error, /at least one action/)
    end
  end

  describe 'computed properties' do
    it '#is_active? returns true by default' do
      rule = described_class.new(valid_attrs)
      expect(rule.is_active?).to be true
    end

    it '#is_active? returns false when disabled' do
      rule = described_class.new(valid_attrs.merge(status: "disabled"))
      expect(rule.is_active?).to be false
    end

    it '#is_wildcard_rule? returns true when target contains wildcard' do
      rule = described_class.new(valid_attrs)
      expect(rule.is_wildcard_rule?).to be true
    end

    it '#is_wildcard_rule? returns false for exact target' do
      rule = described_class.new(valid_attrs.merge(target: "example.com/specific-page"))
      expect(rule.is_wildcard_rule?).to be false
    end

    it '#action_count returns number of actions' do
      rule = described_class.new(valid_attrs.merge(actions: { always_use_https: "on", ssl: "full" }))
      expect(rule.action_count).to eq(2)
    end
  end

  describe 'defaults' do
    let(:rule) { described_class.new(valid_attrs) }

    it 'defaults priority to 1' do
      expect(rule.priority).to eq(1)
    end

    it 'defaults status to active' do
      expect(rule.status).to eq("active")
    end
  end
end
