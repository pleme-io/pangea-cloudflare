# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/types/cloudflare/workers'

RSpec.describe 'Pangea::Resources::Types Cloudflare workers types' do
  let(:types) { Pangea::Resources::Types }

  describe 'CloudflareWorkerRoutePattern' do
    it 'accepts valid route pattern with wildcard path' do
      expect(types::CloudflareWorkerRoutePattern['example.com/*']).to eq('example.com/*')
    end

    it 'accepts route pattern with subdomain wildcard' do
      expect(types::CloudflareWorkerRoutePattern['*.example.com/*']).to eq('*.example.com/*')
    end

    it 'accepts route pattern with specific path' do
      expect(types::CloudflareWorkerRoutePattern['example.com/api/v1/*']).to eq('example.com/api/v1/*')
    end

    it 'rejects pattern without path separator' do
      expect { types::CloudflareWorkerRoutePattern['example.com'] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects pattern with consecutive asterisks' do
      expect { types::CloudflareWorkerRoutePattern['example.com/**'] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects empty string' do
      expect { types::CloudflareWorkerRoutePattern[''] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareWorkerScriptFormat' do
    it 'accepts service-worker format' do
      expect(types::CloudflareWorkerScriptFormat['service-worker']).to eq('service-worker')
    end

    it 'accepts modules format' do
      expect(types::CloudflareWorkerScriptFormat['modules']).to eq('modules')
    end

    it 'rejects invalid format' do
      expect { types::CloudflareWorkerScriptFormat['esm'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareSpectrumProtocol' do
    it 'accepts all valid protocols' do
      %w[tcp/22 tcp/80 tcp/443 tcp/3389 tcp/8080 udp/53].each do |proto|
        expect(types::CloudflareSpectrumProtocol[proto]).to eq(proto)
      end
    end

    it 'rejects invalid protocol' do
      expect { types::CloudflareSpectrumProtocol['tcp/9999'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareCustomHostnameSslSettings' do
    it 'accepts valid SSL settings hash' do
      settings = types::CloudflareCustomHostnameSslSettings[{
        http2: 'on',
        min_tls_version: '1.2'
      }]
      expect(settings[:http2]).to eq('on')
      expect(settings[:min_tls_version]).to eq('1.2')
    end

    it 'accepts empty hash (all fields optional)' do
      expect(types::CloudflareCustomHostnameSslSettings[{}]).to eq({})
    end

    it 'rejects invalid TLS version' do
      expect {
        types::CloudflareCustomHostnameSslSettings[{ min_tls_version: '0.9' }]
      }.to raise_error(Dry::Types::SchemaError)
    end
  end
end
