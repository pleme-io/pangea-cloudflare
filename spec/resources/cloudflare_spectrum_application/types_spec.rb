# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_spectrum_application/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::SpectrumApplicationAttributes do
  let(:zone_id) { "a" * 32 }

  let(:valid_attrs) do
    {
      zone_id: zone_id,
      protocol: "tcp/22",
      dns_name: "ssh.example.com",
      origin_direct: ["tcp://192.0.2.1:22"]
    }
  end

  describe '#protocol_type' do
    it 'returns tcp for tcp protocol' do
      app = described_class.new(valid_attrs)
      expect(app.protocol_type).to eq("tcp")
    end

    it 'returns udp for udp protocol' do
      app = described_class.new(valid_attrs.merge(protocol: "udp/53"))
      expect(app.protocol_type).to eq("udp")
    end
  end

  describe '#port_range' do
    it 'returns single port' do
      app = described_class.new(valid_attrs)
      expect(app.port_range).to eq("22")
    end

    it 'returns port range' do
      app = described_class.new(valid_attrs.merge(protocol: "tcp/8000-9000"))
      expect(app.port_range).to eq("8000-9000")
    end
  end

  describe '#port_range?' do
    it 'returns false for single port' do
      app = described_class.new(valid_attrs)
      expect(app.port_range?).to be false
    end

    it 'returns true for port range' do
      app = described_class.new(valid_attrs.merge(protocol: "tcp/8000-9000"))
      expect(app.port_range?).to be true
    end
  end

  describe '#tls_enabled?' do
    it 'returns false when tls is nil' do
      app = described_class.new(valid_attrs)
      expect(app.tls_enabled?).to be_falsey
    end

    it 'returns false when tls is off' do
      app = described_class.new(valid_attrs.merge(tls: "off"))
      expect(app.tls_enabled?).to be false
    end

    it 'returns true when tls is full' do
      app = described_class.new(valid_attrs.merge(tls: "full"))
      expect(app.tls_enabled?).to be true
    end
  end

  describe 'protocol validation' do
    it 'accepts standard tcp port' do
      app = described_class.new(valid_attrs)
      expect(app.protocol).to eq("tcp/22")
    end

    it 'accepts port range' do
      app = described_class.new(valid_attrs.merge(protocol: "tcp/1000-2000"))
      expect(app.protocol).to eq("tcp/1000-2000")
    end

    it 'rejects invalid protocol format' do
      expect {
        described_class.new(valid_attrs.merge(protocol: "invalid"))
      }.to raise_error(Dry::Struct::Error)
    end
  end
end
