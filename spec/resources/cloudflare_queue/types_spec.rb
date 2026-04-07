# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_queue/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::QueueAttributes do
  let(:account_id) { "a" * 32 }

  let(:valid_attrs) do
    { account_id: account_id, queue_name: "email-tasks" }
  end

  describe '#high_concurrency?' do
    it 'returns true when max_concurrency >= 10' do
      queue = described_class.new(valid_attrs.merge(max_concurrency: 10))
      expect(queue.high_concurrency?).to be true
    end

    it 'returns true when max_concurrency is 50' do
      queue = described_class.new(valid_attrs.merge(max_concurrency: 50))
      expect(queue.high_concurrency?).to be true
    end

    it 'returns false when max_concurrency < 10' do
      queue = described_class.new(valid_attrs.merge(max_concurrency: 5))
      expect(queue.high_concurrency?).to be false
    end

    it 'returns falsy when max_concurrency is nil' do
      queue = described_class.new(valid_attrs)
      expect(queue.high_concurrency?).to be_falsey
    end
  end

  describe '#retries_enabled?' do
    it 'returns true when max_retries > 0' do
      queue = described_class.new(valid_attrs.merge(max_retries: 3))
      expect(queue.retries_enabled?).to be true
    end

    it 'returns false when max_retries is 0' do
      queue = described_class.new(valid_attrs.merge(max_retries: 0))
      expect(queue.retries_enabled?).to be false
    end

    it 'returns falsy when max_retries is nil' do
      queue = described_class.new(valid_attrs)
      expect(queue.retries_enabled?).to be_falsey
    end
  end

  describe '#retention_days' do
    it 'converts seconds to days' do
      queue = described_class.new(valid_attrs.merge(message_retention_period: 86400))
      expect(queue.retention_days).to eq(1.0)
    end

    it 'handles fractional days' do
      queue = described_class.new(valid_attrs.merge(message_retention_period: 43200))
      expect(queue.retention_days).to eq(0.5)
    end

    it 'returns nil when retention period is nil' do
      queue = described_class.new(valid_attrs)
      expect(queue.retention_days).to be_nil
    end

    it 'handles maximum retention of 14 days' do
      queue = described_class.new(valid_attrs.merge(message_retention_period: 1209600))
      expect(queue.retention_days).to eq(14.0)
    end
  end

  describe '#environment' do
    it 'detects production environment' do
      queue = described_class.new(valid_attrs.merge(queue_name: "prod-tasks"))
      expect(queue.environment).to eq('production')
    end

    it 'detects staging environment' do
      queue = described_class.new(valid_attrs.merge(queue_name: "staging-queue"))
      expect(queue.environment).to eq('staging')
    end

    it 'detects development environment' do
      queue = described_class.new(valid_attrs.merge(queue_name: "dev-tasks"))
      expect(queue.environment).to eq('development')
    end

    it 'detects test environment' do
      queue = described_class.new(valid_attrs.merge(queue_name: "test-queue"))
      expect(queue.environment).to eq('test')
    end

    it 'returns nil for unrecognized name' do
      queue = described_class.new(valid_attrs)
      expect(queue.environment).to be_nil
    end
  end

  describe 'validation' do
    it 'rejects empty queue_name' do
      expect {
        described_class.new(valid_attrs.merge(queue_name: ""))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects max_concurrency above 100' do
      expect {
        described_class.new(valid_attrs.merge(max_concurrency: 101))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects max_concurrency below 1' do
      expect {
        described_class.new(valid_attrs.merge(max_concurrency: 0))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects max_retries above 100' do
      expect {
        described_class.new(valid_attrs.merge(max_retries: 101))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects message_retention_period below 60' do
      expect {
        described_class.new(valid_attrs.merge(message_retention_period: 59))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects message_retention_period above 1209600' do
      expect {
        described_class.new(valid_attrs.merge(message_retention_period: 1209601))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts boundary value for max_concurrency' do
      queue = described_class.new(valid_attrs.merge(max_concurrency: 1))
      expect(queue.max_concurrency).to eq(1)
    end

    it 'accepts boundary value for max_concurrency upper' do
      queue = described_class.new(valid_attrs.merge(max_concurrency: 100))
      expect(queue.max_concurrency).to eq(100)
    end

    it 'accepts minimum retention period' do
      queue = described_class.new(valid_attrs.merge(message_retention_period: 60))
      expect(queue.message_retention_period).to eq(60)
    end
  end
end
