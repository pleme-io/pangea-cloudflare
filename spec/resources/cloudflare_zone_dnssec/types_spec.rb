# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_zone_dnssec/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::ZoneDnssecAttributes do
  let(:zone_id) { "a" * 32 }

  let(:valid_attrs) do
    { zone_id: zone_id }
  end

  describe '#using_external_signatures?' do
    it 'returns true when dnssec_presigned is true' do
      dnssec = described_class.new(valid_attrs.merge(dnssec_presigned: true))
      expect(dnssec.using_external_signatures?).to be true
    end

    it 'returns false when dnssec_presigned is false' do
      dnssec = described_class.new(valid_attrs.merge(dnssec_presigned: false))
      expect(dnssec.using_external_signatures?).to be false
    end

    it 'returns false when dnssec_presigned is nil' do
      dnssec = described_class.new(valid_attrs)
      expect(dnssec.using_external_signatures?).to be false
    end
  end

  describe '#multi_signer_enabled?' do
    it 'returns true when dnssec_multi_signer is true' do
      dnssec = described_class.new(valid_attrs.merge(dnssec_multi_signer: true))
      expect(dnssec.multi_signer_enabled?).to be true
    end

    it 'returns false when dnssec_multi_signer is false' do
      dnssec = described_class.new(valid_attrs.merge(dnssec_multi_signer: false))
      expect(dnssec.multi_signer_enabled?).to be false
    end

    it 'returns false when dnssec_multi_signer is nil' do
      dnssec = described_class.new(valid_attrs)
      expect(dnssec.multi_signer_enabled?).to be false
    end
  end

  describe '#dnssec_mode' do
    it 'returns Presigned when using external signatures' do
      dnssec = described_class.new(valid_attrs.merge(dnssec_presigned: true))
      expect(dnssec.dnssec_mode).to eq("Presigned (external provider)")
    end

    it 'returns Multi-signer when multi_signer enabled' do
      dnssec = described_class.new(valid_attrs.merge(dnssec_multi_signer: true))
      expect(dnssec.dnssec_mode).to eq("Multi-signer (multiple providers)")
    end

    it 'returns Cloudflare-managed by default' do
      dnssec = described_class.new(valid_attrs)
      expect(dnssec.dnssec_mode).to eq("Cloudflare-managed")
    end

    it 'prioritizes presigned over multi-signer' do
      dnssec = described_class.new(valid_attrs.merge(dnssec_presigned: true, dnssec_multi_signer: true))
      expect(dnssec.dnssec_mode).to eq("Presigned (external provider)")
    end
  end

  describe 'defaults' do
    let(:dnssec) { described_class.new(valid_attrs) }

    it 'defaults dnssec_presigned to nil' do
      expect(dnssec.dnssec_presigned).to be_nil
    end

    it 'defaults dnssec_multi_signer to nil' do
      expect(dnssec.dnssec_multi_signer).to be_nil
    end
  end
end
