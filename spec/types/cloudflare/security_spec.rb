# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/types/cloudflare/security'

RSpec.describe 'Pangea::Resources::Types Cloudflare security types' do
  let(:types) { Pangea::Resources::Types }

  describe 'CloudflareFilterExpression' do
    it 'accepts valid filter expression' do
      expect(types::CloudflareFilterExpression['ip.src eq 1.2.3.4']).to eq('ip.src eq 1.2.3.4')
    end

    it 'rejects empty string' do
      expect { types::CloudflareFilterExpression[''] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects whitespace-only string' do
      expect { types::CloudflareFilterExpression['   '] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareAccessSessionDuration' do
    it 'accepts hours format' do
      expect(types::CloudflareAccessSessionDuration['24h']).to eq('24h')
    end

    it 'accepts minutes format' do
      expect(types::CloudflareAccessSessionDuration['30m']).to eq('30m')
    end

    it 'accepts days format' do
      expect(types::CloudflareAccessSessionDuration['7d']).to eq('7d')
    end

    it 'rejects missing time unit' do
      expect { types::CloudflareAccessSessionDuration['24'] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects invalid time unit' do
      expect { types::CloudflareAccessSessionDuration['24s'] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects non-numeric prefix' do
      expect { types::CloudflareAccessSessionDuration['abch'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareFirewallAction' do
    it 'accepts all valid actions' do
      %w[block challenge js_challenge managed_challenge allow log bypass].each do |action|
        expect(types::CloudflareFirewallAction[action]).to eq(action)
      end
    end

    it 'rejects invalid action' do
      expect { types::CloudflareFirewallAction['drop'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareRateLimitThreshold' do
    it 'accepts minimum threshold of 2' do
      expect(types::CloudflareRateLimitThreshold[2]).to eq(2)
    end

    it 'accepts maximum threshold of 1000000' do
      expect(types::CloudflareRateLimitThreshold[1000000]).to eq(1000000)
    end

    it 'rejects threshold of 1 (minimum is 2)' do
      expect { types::CloudflareRateLimitThreshold[1] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects threshold of 0' do
      expect { types::CloudflareRateLimitThreshold[0] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects threshold above 1000000' do
      expect { types::CloudflareRateLimitThreshold[1000001] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareRateLimitPeriod' do
    it 'accepts minimum period of 1 second' do
      expect(types::CloudflareRateLimitPeriod[1]).to eq(1)
    end

    it 'accepts maximum period of 86400 seconds' do
      expect(types::CloudflareRateLimitPeriod[86400]).to eq(86400)
    end

    it 'rejects period of 0' do
      expect { types::CloudflareRateLimitPeriod[0] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects period above 86400' do
      expect { types::CloudflareRateLimitPeriod[86401] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareRateLimitActionTimeout' do
    it 'accepts minimum timeout of 10 seconds' do
      expect(types::CloudflareRateLimitActionTimeout[10]).to eq(10)
    end

    it 'accepts maximum timeout of 86400 seconds' do
      expect(types::CloudflareRateLimitActionTimeout[86400]).to eq(86400)
    end

    it 'rejects timeout below 10' do
      expect { types::CloudflareRateLimitActionTimeout[9] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareAccessApplicationType' do
    it 'accepts all valid application types' do
      %w[self_hosted saas ssh vnc app_launcher warp biso bookmark].each do |app_type|
        expect(types::CloudflareAccessApplicationType[app_type]).to eq(app_type)
      end
    end

    it 'rejects invalid application type' do
      expect { types::CloudflareAccessApplicationType['web'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareAccessPolicyDecision' do
    it 'accepts all valid decisions' do
      %w[allow deny non_identity bypass].each do |decision|
        expect(types::CloudflareAccessPolicyDecision[decision]).to eq(decision)
      end
    end

    it 'rejects invalid decision' do
      expect { types::CloudflareAccessPolicyDecision['block'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end
end
