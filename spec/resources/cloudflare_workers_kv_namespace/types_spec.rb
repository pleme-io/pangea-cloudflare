# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_workers_kv_namespace/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::WorkersKvNamespaceAttributes do
  let(:account_id) { "a" * 32 }

  let(:valid_attrs) do
    { account_id: account_id, title: "Production Cache" }
  end

  describe '#follows_naming_convention?' do
    it 'returns true for alphanumeric with hyphens' do
      ns = described_class.new(valid_attrs.merge(title: "prod-cache-v2"))
      expect(ns.follows_naming_convention?).to be true
    end

    it 'returns true for alphanumeric with underscores' do
      ns = described_class.new(valid_attrs.merge(title: "prod_cache"))
      expect(ns.follows_naming_convention?).to be true
    end

    it 'returns false for title with spaces' do
      ns = described_class.new(valid_attrs)
      expect(ns.follows_naming_convention?).to be false
    end
  end

  describe '#environment' do
    it 'detects production environment' do
      ns = described_class.new(valid_attrs.merge(title: "Production Cache"))
      expect(ns.environment).to eq('production')
    end

    it 'detects staging environment' do
      ns = described_class.new(valid_attrs.merge(title: "staging-cache"))
      expect(ns.environment).to eq('staging')
    end

    it 'detects development environment' do
      ns = described_class.new(valid_attrs.merge(title: "dev-sessions"))
      expect(ns.environment).to eq('development')
    end

    it 'detects test environment' do
      ns = described_class.new(valid_attrs.merge(title: "test-namespace"))
      expect(ns.environment).to eq('test')
    end

    it 'returns nil for unrecognized name' do
      ns = described_class.new(valid_attrs.merge(title: "my-namespace"))
      expect(ns.environment).to be_nil
    end
  end

  describe 'validation' do
    it 'rejects empty title' do
      expect {
        described_class.new(valid_attrs.merge(title: ""))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects title exceeding 256 characters' do
      expect {
        described_class.new(valid_attrs.merge(title: "x" * 257))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts title at max length' do
      ns = described_class.new(valid_attrs.merge(title: "x" * 256))
      expect(ns.title.length).to eq(256)
    end
  end
end
