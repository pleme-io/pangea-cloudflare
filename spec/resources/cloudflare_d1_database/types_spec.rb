# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_d1_database/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::D1DatabaseAttributes do
  let(:account_id) { "a" * 32 }

  let(:valid_attrs) do
    { account_id: account_id, name: "test-db" }
  end

  describe '#region_name' do
    it 'returns Western North America for wnam' do
      db = described_class.new(valid_attrs.merge(primary_location_hint: "wnam"))
      expect(db.region_name).to eq('Western North America')
    end

    it 'returns Eastern North America for enam' do
      db = described_class.new(valid_attrs.merge(primary_location_hint: "enam"))
      expect(db.region_name).to eq('Eastern North America')
    end

    it 'returns Western Europe for weur' do
      db = described_class.new(valid_attrs.merge(primary_location_hint: "weur"))
      expect(db.region_name).to eq('Western Europe')
    end

    it 'returns Eastern Europe for eeur' do
      db = described_class.new(valid_attrs.merge(primary_location_hint: "eeur"))
      expect(db.region_name).to eq('Eastern Europe')
    end

    it 'returns Asia-Pacific for apac' do
      db = described_class.new(valid_attrs.merge(primary_location_hint: "apac"))
      expect(db.region_name).to eq('Asia-Pacific')
    end

    it 'returns Oceania for oc' do
      db = described_class.new(valid_attrs.merge(primary_location_hint: "oc"))
      expect(db.region_name).to eq('Oceania')
    end

    it 'returns Automatic when no location hint' do
      db = described_class.new(valid_attrs)
      expect(db.region_name).to eq('Automatic')
    end
  end

  describe '#environment' do
    it 'detects production environment' do
      db = described_class.new(valid_attrs.merge(name: "app-production"))
      expect(db.environment).to eq('production')
    end

    it 'detects prod shorthand' do
      db = described_class.new(valid_attrs.merge(name: "app-prod-db"))
      expect(db.environment).to eq('production')
    end

    it 'detects staging environment' do
      db = described_class.new(valid_attrs.merge(name: "app-staging"))
      expect(db.environment).to eq('staging')
    end

    it 'detects development environment' do
      db = described_class.new(valid_attrs.merge(name: "app-development"))
      expect(db.environment).to eq('development')
    end

    it 'detects dev shorthand' do
      db = described_class.new(valid_attrs.merge(name: "app-dev"))
      expect(db.environment).to eq('development')
    end

    it 'detects test environment' do
      db = described_class.new(valid_attrs.merge(name: "app-test"))
      expect(db.environment).to eq('test')
    end

    it 'returns nil for unrecognized name' do
      db = described_class.new(valid_attrs.merge(name: "my-app"))
      expect(db.environment).to be_nil
    end
  end

  describe '#production?' do
    it 'returns true for production database' do
      db = described_class.new(valid_attrs.merge(name: "app-production"))
      expect(db.production?).to be true
    end

    it 'returns false for staging database' do
      db = described_class.new(valid_attrs.merge(name: "app-staging"))
      expect(db.production?).to be false
    end
  end

  describe 'validation' do
    it 'rejects empty name' do
      expect {
        described_class.new(valid_attrs.merge(name: ""))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects name longer than 256 characters' do
      expect {
        described_class.new(valid_attrs.merge(name: "x" * 257))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects invalid location hint' do
      expect {
        described_class.new(valid_attrs.merge(primary_location_hint: "mars"))
      }.to raise_error(Dry::Struct::Error)
    end
  end
end
