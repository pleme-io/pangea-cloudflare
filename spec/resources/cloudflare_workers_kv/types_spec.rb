# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_workers_kv/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::WorkersKvAttributes do
  let(:account_id) { "a" * 32 }
  let(:namespace_id) { "b" * 32 }

  let(:valid_attrs) do
    { account_id: account_id, namespace_id: namespace_id, key_name: "config", value: "test-value" }
  end

  describe '#json_value?' do
    it 'returns true for valid JSON value' do
      kv = described_class.new(valid_attrs.merge(value: '{"key":"value"}'))
      expect(kv.json_value?).to be true
    end

    it 'returns true for JSON array' do
      kv = described_class.new(valid_attrs.merge(value: '[1,2,3]'))
      expect(kv.json_value?).to be true
    end

    it 'returns false for plain text' do
      kv = described_class.new(valid_attrs)
      expect(kv.json_value?).to be false
    end

    it 'returns false for invalid JSON' do
      kv = described_class.new(valid_attrs.merge(value: '{broken'))
      expect(kv.json_value?).to be false
    end
  end

  describe '#key_size' do
    it 'returns byte size of key' do
      kv = described_class.new(valid_attrs)
      expect(kv.key_size).to eq("config".bytesize)
    end

    it 'handles multi-byte characters' do
      kv = described_class.new(valid_attrs.merge(key_name: "日本語"))
      expect(kv.key_size).to be > 3
    end
  end

  describe '#value_size' do
    it 'returns byte size of value' do
      kv = described_class.new(valid_attrs)
      expect(kv.value_size).to eq("test-value".bytesize)
    end
  end

  describe '#large_value?' do
    it 'returns false for small value' do
      kv = described_class.new(valid_attrs)
      expect(kv.large_value?).to be false
    end
  end

  describe '#metadata_json' do
    it 'returns JSON string when metadata present' do
      kv = described_class.new(valid_attrs.merge(metadata: { "env" => "prod" }))
      parsed = JSON.parse(kv.metadata_json)
      expect(parsed["env"]).to eq("prod")
    end

    it 'returns nil when no metadata' do
      kv = described_class.new(valid_attrs)
      expect(kv.metadata_json).to be_nil
    end
  end

  describe 'validation' do
    it 'accepts valid namespace_id (32-char hex)' do
      kv = described_class.new(valid_attrs)
      expect(kv.namespace_id).to eq(namespace_id)
    end

    it 'accepts Terraform interpolation for namespace_id' do
      kv = described_class.new(valid_attrs.merge(namespace_id: '${cloudflare_workers_kv_namespace.test.id}'))
      expect(kv.namespace_id).to eq('${cloudflare_workers_kv_namespace.test.id}')
    end

    it 'rejects invalid namespace_id format' do
      expect {
        described_class.new(valid_attrs.merge(namespace_id: "short"))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects empty key_name' do
      expect {
        described_class.new(valid_attrs.merge(key_name: ""))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects key_name exceeding 512 bytes' do
      expect {
        described_class.new(valid_attrs.merge(key_name: "k" * 513))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts maximum key_name length of 512' do
      kv = described_class.new(valid_attrs.merge(key_name: "k" * 512))
      expect(kv.key_name.length).to eq(512)
    end
  end
end
