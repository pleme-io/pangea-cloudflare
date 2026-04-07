# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/types/cloudflare/load_balancing'

RSpec.describe 'Pangea::Resources::Types Cloudflare load balancing types' do
  let(:types) { Pangea::Resources::Types }

  describe 'CloudflareMonitorExpectedCodes' do
    it 'accepts wildcard format like 2xx' do
      expect(types::CloudflareMonitorExpectedCodes['2xx']).to eq('2xx')
    end

    it 'accepts specific code like 200' do
      expect(types::CloudflareMonitorExpectedCodes['200']).to eq('200')
    end

    it 'accepts range format like 200-299' do
      expect(types::CloudflareMonitorExpectedCodes['200-299']).to eq('200-299')
    end

    it 'rejects invalid format' do
      expect { types::CloudflareMonitorExpectedCodes['ok'] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects partial format' do
      expect { types::CloudflareMonitorExpectedCodes['20'] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects empty string' do
      expect { types::CloudflareMonitorExpectedCodes[''] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareMonitorInterval' do
    it 'accepts minimum interval of 5' do
      expect(types::CloudflareMonitorInterval[5]).to eq(5)
    end

    it 'accepts maximum interval of 3600' do
      expect(types::CloudflareMonitorInterval[3600]).to eq(3600)
    end

    it 'rejects interval below 5' do
      expect { types::CloudflareMonitorInterval[4] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects interval above 3600' do
      expect { types::CloudflareMonitorInterval[3601] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareMonitorTimeout' do
    it 'accepts minimum timeout of 1' do
      expect(types::CloudflareMonitorTimeout[1]).to eq(1)
    end

    it 'accepts maximum timeout of 10' do
      expect(types::CloudflareMonitorTimeout[10]).to eq(10)
    end

    it 'rejects timeout of 0' do
      expect { types::CloudflareMonitorTimeout[0] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects timeout above 10' do
      expect { types::CloudflareMonitorTimeout[11] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareMonitorRetries' do
    it 'accepts 0 retries' do
      expect(types::CloudflareMonitorRetries[0]).to eq(0)
    end

    it 'accepts maximum retries of 5' do
      expect(types::CloudflareMonitorRetries[5]).to eq(5)
    end

    it 'rejects negative retries' do
      expect { types::CloudflareMonitorRetries[-1] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects retries above 5' do
      expect { types::CloudflareMonitorRetries[6] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareLoadBalancerSteeringPolicy' do
    it 'accepts all valid steering policies' do
      %w[off geo random dynamic_latency proximity least_outstanding_requests least_connections].each do |policy|
        expect(types::CloudflareLoadBalancerSteeringPolicy[policy]).to eq(policy)
      end
    end

    it 'rejects invalid steering policy' do
      expect { types::CloudflareLoadBalancerSteeringPolicy['round_robin'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareLoadBalancerSessionAffinity' do
    it 'accepts all valid session affinity types' do
      %w[none cookie ip_cookie header].each do |affinity|
        expect(types::CloudflareLoadBalancerSessionAffinity[affinity]).to eq(affinity)
      end
    end

    it 'rejects invalid session affinity' do
      expect { types::CloudflareLoadBalancerSessionAffinity['sticky'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareHealthCheckRegion' do
    it 'accepts all valid regions' do
      %w[WNAM ENAM WEU EEU NSAM SSAM OC ME NAF SAF SAS SEAS NEAS ALL_REGIONS].each do |region|
        expect(types::CloudflareHealthCheckRegion[region]).to eq(region)
      end
    end

    it 'rejects lowercase region' do
      expect { types::CloudflareHealthCheckRegion['wnam'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflarePopPool' do
    it 'accepts valid pop pool with 3-letter uppercase code' do
      pool = types::CloudflarePopPool[{ pop: 'LAX', pool_ids: ['pool-1'] }]
      expect(pool[:pop]).to eq('LAX')
    end

    it 'rejects pop code that is not 3 uppercase letters' do
      expect {
        types::CloudflarePopPool[{ pop: 'lax', pool_ids: ['pool-1'] }]
      }.to raise_error(Dry::Types::SchemaError)
    end

    it 'rejects pop code that is wrong length' do
      expect {
        types::CloudflarePopPool[{ pop: 'LA', pool_ids: ['pool-1'] }]
      }.to raise_error(Dry::Types::SchemaError)
    end

    it 'rejects empty pool_ids' do
      expect {
        types::CloudflarePopPool[{ pop: 'LAX', pool_ids: [] }]
      }.to raise_error(Dry::Types::SchemaError)
    end
  end

  describe 'CloudflareMonitorType' do
    it 'accepts all valid monitor types' do
      %w[http https tcp udp_icmp icmp_ping smtp].each do |type|
        expect(types::CloudflareMonitorType[type]).to eq(type)
      end
    end

    it 'rejects invalid monitor type' do
      expect { types::CloudflareMonitorType['grpc'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareMonitorMethod' do
    it 'accepts all valid HTTP methods' do
      %w[GET HEAD POST PUT DELETE CONNECT OPTIONS TRACE PATCH].each do |method|
        expect(types::CloudflareMonitorMethod[method]).to eq(method)
      end
    end

    it 'rejects lowercase method' do
      expect { types::CloudflareMonitorMethod['get'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end
end
