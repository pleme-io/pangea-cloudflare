# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_origin_ca_certificate/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::OriginCACertificateAttributes do
  let(:valid_attrs) do
    {
      csr: "-----BEGIN CERTIFICATE REQUEST-----\ntest\n-----END CERTIFICATE REQUEST-----",
      hostnames: ["example.com"],
      request_type: "origin-rsa",
      requested_validity: 365
    }
  end

  describe 'computed properties' do
    it '#rsa? returns true for origin-rsa' do
      cert = described_class.new(valid_attrs)
      expect(cert.rsa?).to be true
    end

    it '#ecc? returns true for origin-ecc' do
      cert = described_class.new(valid_attrs.merge(request_type: "origin-ecc"))
      expect(cert.ecc?).to be true
    end

    it '#keyless? returns true for keyless-certificate' do
      cert = described_class.new(valid_attrs.merge(request_type: "keyless-certificate"))
      expect(cert.keyless?).to be true
    end

    it '#has_wildcards? returns true when wildcard hostname present' do
      cert = described_class.new(valid_attrs.merge(hostnames: ["*.example.com", "example.com"]))
      expect(cert.has_wildcards?).to be true
    end

    it '#has_wildcards? returns false for exact hostnames' do
      cert = described_class.new(valid_attrs)
      expect(cert.has_wildcards?).to be false
    end

    it '#validity_description returns readable format' do
      expect(described_class.new(valid_attrs.merge(requested_validity: 7)).validity_description).to eq("1 week")
      expect(described_class.new(valid_attrs.merge(requested_validity: 30)).validity_description).to eq("1 month")
      expect(described_class.new(valid_attrs.merge(requested_validity: 90)).validity_description).to eq("3 months")
      expect(described_class.new(valid_attrs.merge(requested_validity: 365)).validity_description).to eq("1 year")
      expect(described_class.new(valid_attrs.merge(requested_validity: 730)).validity_description).to eq("2 years")
      expect(described_class.new(valid_attrs.merge(requested_validity: 1095)).validity_description).to eq("3 years")
      expect(described_class.new(valid_attrs.merge(requested_validity: 5475)).validity_description).to eq("15 years")
    end
  end

  describe 'validation' do
    it 'rejects invalid request_type' do
      expect {
        described_class.new(valid_attrs.merge(request_type: "invalid"))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects invalid validity period' do
      expect {
        described_class.new(valid_attrs.merge(requested_validity: 100))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects empty hostnames' do
      expect {
        described_class.new(valid_attrs.merge(hostnames: []))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects empty CSR' do
      expect {
        described_class.new(valid_attrs.merge(csr: ""))
      }.to raise_error(Dry::Struct::Error)
    end
  end
end
