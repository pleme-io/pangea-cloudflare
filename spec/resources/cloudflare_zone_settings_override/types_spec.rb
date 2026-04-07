# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_zone_settings_override/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::ZoneSettingsOverrideAttributes do
  let(:zone_id) { "a" * 32 }

  let(:valid_attrs) do
    { zone_id: zone_id }
  end

  describe '#has_settings?' do
    it 'returns false when no settings' do
      override = described_class.new(valid_attrs)
      expect(override.has_settings?).to be_falsey
    end

    it 'returns true when settings present' do
      override = described_class.new(valid_attrs.merge(settings: { ssl: "full" }))
      expect(override.has_settings?).to be true
    end
  end

  describe '#setting_count' do
    it 'returns 0 when no settings' do
      override = described_class.new(valid_attrs)
      expect(override.setting_count).to eq(0)
    end

    it 'returns count of settings' do
      override = described_class.new(valid_attrs.merge(settings: { ssl: "full", security_level: "high" }))
      expect(override.setting_count).to eq(2)
    end
  end

  describe '#ssl_mode' do
    it 'returns SSL mode from settings' do
      override = described_class.new(valid_attrs.merge(settings: { ssl: "strict" }))
      expect(override.ssl_mode).to eq("strict")
    end

    it 'returns nil when not set' do
      override = described_class.new(valid_attrs)
      expect(override.ssl_mode).to be_nil
    end
  end

  describe '#security_level' do
    it 'returns security level from settings' do
      override = described_class.new(valid_attrs.merge(settings: { security_level: "high" }))
      expect(override.security_level).to eq("high")
    end
  end

  describe '#cache_level' do
    it 'returns cache level from settings' do
      override = described_class.new(valid_attrs.merge(settings: { cache_level: "aggressive" }))
      expect(override.cache_level).to eq("aggressive")
    end
  end

  describe '#always_use_https?' do
    it 'returns true when always_use_https is on' do
      override = described_class.new(valid_attrs.merge(settings: { always_use_https: "on" }))
      expect(override.always_use_https?).to be true
    end

    it 'returns false when always_use_https is off' do
      override = described_class.new(valid_attrs.merge(settings: { always_use_https: "off" }))
      expect(override.always_use_https?).to be false
    end

    it 'returns false when not set' do
      override = described_class.new(valid_attrs)
      expect(override.always_use_https?).to be_falsey
    end
  end
end
