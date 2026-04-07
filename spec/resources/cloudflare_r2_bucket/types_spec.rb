# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_r2_bucket/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::R2BucketAttributes do
  let(:account_id) { "a" * 32 }

  let(:valid_attrs) do
    { account_id: account_id, name: "media-assets" }
  end

  describe '#region_name' do
    it 'returns Asia-Pacific for apac' do
      bucket = described_class.new(valid_attrs.merge(location: "apac"))
      expect(bucket.region_name).to eq('Asia-Pacific')
    end

    it 'returns Eastern Europe for eeur' do
      bucket = described_class.new(valid_attrs.merge(location: "eeur"))
      expect(bucket.region_name).to eq('Eastern Europe')
    end

    it 'returns Eastern North America for enam' do
      bucket = described_class.new(valid_attrs.merge(location: "enam"))
      expect(bucket.region_name).to eq('Eastern North America')
    end

    it 'returns Western Europe for weur' do
      bucket = described_class.new(valid_attrs.merge(location: "weur"))
      expect(bucket.region_name).to eq('Western Europe')
    end

    it 'returns Western North America for wnam' do
      bucket = described_class.new(valid_attrs.merge(location: "wnam"))
      expect(bucket.region_name).to eq('Western North America')
    end

    it 'returns Oceania for oc' do
      bucket = described_class.new(valid_attrs.merge(location: "oc"))
      expect(bucket.region_name).to eq('Oceania')
    end

    it 'returns Automatic when no location' do
      bucket = described_class.new(valid_attrs)
      expect(bucket.region_name).to eq('Automatic')
    end
  end

  describe '#s3_compatible_name?' do
    it 'returns true for valid S3-compatible name' do
      bucket = described_class.new(valid_attrs)
      expect(bucket.s3_compatible_name?).to be true
    end

    it 'returns true for name with hyphens' do
      bucket = described_class.new(valid_attrs.merge(name: "my-test-bucket"))
      expect(bucket.s3_compatible_name?).to be true
    end
  end

  describe '#s3_endpoint' do
    it 'returns the S3-compatible endpoint pattern' do
      bucket = described_class.new(valid_attrs)
      expect(bucket.s3_endpoint).to eq("<account_id>.r2.cloudflarestorage.com")
    end
  end

  describe 'validation' do
    it 'rejects bucket name shorter than 3 characters' do
      expect {
        described_class.new(valid_attrs.merge(name: "ab"))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects bucket name with uppercase letters' do
      expect {
        described_class.new(valid_attrs.merge(name: "MyBucket"))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects bucket name starting with hyphen' do
      expect {
        described_class.new(valid_attrs.merge(name: "-my-bucket"))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects invalid location' do
      expect {
        described_class.new(valid_attrs.merge(location: "invalid"))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts valid bucket with location' do
      bucket = described_class.new(valid_attrs.merge(location: "wnam"))
      expect(bucket.name).to eq("media-assets")
      expect(bucket.location).to eq("wnam")
    end
  end
end
