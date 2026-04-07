# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_zone/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::ZoneAttributes do
  let(:valid_attrs) do
    { zone: "example.com" }
  end

  describe 'computed properties' do
    it '#is_active? returns true when not paused' do
      zone = described_class.new(valid_attrs)
      expect(zone.is_active?).to be true
    end

    it '#is_active? returns false when paused' do
      zone = described_class.new(valid_attrs.merge(paused: true))
      expect(zone.is_active?).to be false
    end

    it '#is_enterprise? returns true for enterprise plan' do
      zone = described_class.new(valid_attrs.merge(plan: "enterprise"))
      expect(zone.is_enterprise?).to be true
    end

    it '#is_enterprise? returns false for free plan' do
      zone = described_class.new(valid_attrs)
      expect(zone.is_enterprise?).to be false
    end

    it '#is_free? returns true for free plan' do
      zone = described_class.new(valid_attrs)
      expect(zone.is_free?).to be true
    end

    it '#is_free? returns false for pro plan' do
      zone = described_class.new(valid_attrs.merge(plan: "pro"))
      expect(zone.is_free?).to be false
    end

    it '#zone_root_domain returns domain for root domain' do
      zone = described_class.new(valid_attrs)
      expect(zone.zone_root_domain).to eq("example.com")
    end

    it '#zone_root_domain extracts root from subdomain' do
      zone = described_class.new(valid_attrs.merge(zone: "app.staging.example.com"))
      expect(zone.zone_root_domain).to eq("example.com")
    end

    it '#is_subdomain? returns false for root domain' do
      zone = described_class.new(valid_attrs)
      expect(zone.is_subdomain?).to be false
    end

    it '#is_subdomain? returns true for subdomain' do
      zone = described_class.new(valid_attrs.merge(zone: "app.example.com"))
      expect(zone.is_subdomain?).to be true
    end
  end

  describe 'defaults' do
    let(:zone) { described_class.new(valid_attrs) }

    it 'defaults jump_start to false' do
      expect(zone.jump_start).to be false
    end

    it 'defaults paused to false' do
      expect(zone.paused).to be false
    end

    it 'defaults plan to free' do
      expect(zone.plan).to eq('free')
    end

    it 'defaults type to full' do
      expect(zone.type).to eq('full')
    end

    it 'defaults account_id to nil' do
      expect(zone.account_id).to be_nil
    end
  end
end
