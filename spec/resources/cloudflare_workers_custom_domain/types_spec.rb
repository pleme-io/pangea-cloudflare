# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_workers_custom_domain/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::WorkersCustomDomainAttributes do
  let(:account_id) { "a" * 32 }
  let(:zone_id) { "b" * 32 }

  let(:valid_attrs) do
    { account_id: account_id, zone_id: zone_id, hostname: "api.example.com", service: "api-worker" }
  end

  describe '#production?' do
    it 'returns true for production environment' do
      domain = described_class.new(valid_attrs)
      expect(domain.production?).to be true
    end

    it 'returns false for staging environment' do
      domain = described_class.new(valid_attrs.merge(environment: "staging"))
      expect(domain.production?).to be false
    end
  end

  describe '#subdomain?' do
    it 'returns true for subdomain hostname' do
      domain = described_class.new(valid_attrs)
      expect(domain.subdomain?).to be true
    end

    it 'returns false for root domain' do
      domain = described_class.new(valid_attrs.merge(hostname: "example.com"))
      expect(domain.subdomain?).to be false
    end
  end

  describe '#subdomain_part' do
    it 'returns subdomain for subdomain hostname' do
      domain = described_class.new(valid_attrs)
      expect(domain.subdomain_part).to eq("api")
    end

    it 'returns nil for root domain' do
      domain = described_class.new(valid_attrs.merge(hostname: "example.com"))
      expect(domain.subdomain_part).to be_nil
    end
  end
end
