# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_list_item/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::ListItemAttributes do
  let(:account_id) { "a" * 32 }
  let(:list_id) { "b" * 32 }

  describe 'custom validation' do
    it 'rejects when no item type is specified' do
      expect {
        described_class.new(account_id: account_id, list_id: list_id)
      }.to raise_error(Dry::Struct::Error, /Must specify exactly one/)
    end

    it 'accepts IP item' do
      item = described_class.new(account_id: account_id, list_id: list_id, ip: "192.0.2.0/24")
      expect(item.ip_item?).to be true
    end

    it 'accepts ASN item' do
      item = described_class.new(account_id: account_id, list_id: list_id, asn: 13335)
      expect(item.asn_item?).to be true
    end

    it 'accepts hostname item' do
      item = described_class.new(account_id: account_id, list_id: list_id, hostname: { url_hostname: "example.com" })
      expect(item.hostname_item?).to be true
    end

    it 'accepts redirect item' do
      item = described_class.new(
        account_id: account_id, list_id: list_id,
        redirect: { source_url: "example.com/old", target_url: "https://example.com/new" }
      )
      expect(item.redirect_item?).to be true
    end
  end

  describe '#item_type' do
    it 'returns ip for IP items' do
      item = described_class.new(account_id: account_id, list_id: list_id, ip: "10.0.0.0/8")
      expect(item.item_type).to eq('ip')
    end

    it 'returns asn for ASN items' do
      item = described_class.new(account_id: account_id, list_id: list_id, asn: 13335)
      expect(item.item_type).to eq('asn')
    end

    it 'returns hostname for hostname items' do
      item = described_class.new(account_id: account_id, list_id: list_id, hostname: { url_hostname: "example.com" })
      expect(item.item_type).to eq('hostname')
    end

    it 'returns redirect for redirect items' do
      item = described_class.new(
        account_id: account_id, list_id: list_id,
        redirect: { source_url: "a.com/b", target_url: "https://c.com/d" }
      )
      expect(item.item_type).to eq('redirect')
    end
  end
end
