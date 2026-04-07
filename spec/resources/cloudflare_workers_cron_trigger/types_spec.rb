# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_workers_cron_trigger/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::WorkersCronTriggerAttributes do
  let(:account_id) { "a" * 32 }

  let(:valid_attrs) do
    { account_id: account_id, script_name: "cleanup-worker", schedules: ["0 2 * * *"] }
  end

  describe 'CloudflareCronExpression type' do
    let(:cron_type) { Pangea::Resources::Cloudflare::Types::CloudflareCronExpression }

    it 'accepts 5-field cron expression' do
      expect(cron_type["0 2 * * *"]).to eq("0 2 * * *")
    end

    it 'accepts 6-field cron expression' do
      expect(cron_type["0 2 * * * *"]).to eq("0 2 * * * *")
    end

    it 'rejects 4-field cron expression' do
      expect { cron_type["0 2 * *"] }.to raise_error(Dry::Types::ConstraintError, /5 or 6 fields/)
    end

    it 'rejects 7-field cron expression' do
      expect { cron_type["0 2 * * * * *"] }.to raise_error(Dry::Types::ConstraintError, /5 or 6 fields/)
    end
  end

  describe '#frequent_schedule?' do
    it 'returns true for every-minute schedule' do
      trigger = described_class.new(valid_attrs.merge(schedules: ["*/1 * * * *"]))
      expect(trigger.frequent_schedule?).to be true
    end

    it 'returns true for every-5-minutes schedule' do
      trigger = described_class.new(valid_attrs.merge(schedules: ["*/5 * * * *"]))
      expect(trigger.frequent_schedule?).to be true
    end

    it 'returns false for hourly schedule' do
      trigger = described_class.new(valid_attrs.merge(schedules: ["0 * * * *"]))
      expect(trigger.frequent_schedule?).to be false
    end
  end

  describe '#schedule_description' do
    it 'returns Every minute for * * * * *' do
      trigger = described_class.new(valid_attrs.merge(schedules: ["* * * * *"]))
      expect(trigger.schedule_description).to eq("Every minute")
    end

    it 'returns Every 5 minutes for */5 * * * *' do
      trigger = described_class.new(valid_attrs.merge(schedules: ["*/5 * * * *"]))
      expect(trigger.schedule_description).to eq("Every 5 minutes")
    end

    it 'returns Every 30 minutes for */30 * * * *' do
      trigger = described_class.new(valid_attrs.merge(schedules: ["*/30 * * * *"]))
      expect(trigger.schedule_description).to eq("Every 30 minutes")
    end

    it 'returns Every hour for 0 * * * *' do
      trigger = described_class.new(valid_attrs.merge(schedules: ["0 * * * *"]))
      expect(trigger.schedule_description).to eq("Every hour")
    end

    it 'returns Daily at midnight for 0 0 * * *' do
      trigger = described_class.new(valid_attrs.merge(schedules: ["0 0 * * *"]))
      expect(trigger.schedule_description).to eq("Daily at midnight")
    end

    it 'returns Daily at 2 AM for 0 2 * * *' do
      trigger = described_class.new(valid_attrs)
      expect(trigger.schedule_description).to eq("Daily at 2 AM")
    end

    it 'returns Custom schedule for unrecognized patterns' do
      trigger = described_class.new(valid_attrs.merge(schedules: ["0 9 * * 1-5"]))
      expect(trigger.schedule_description).to eq("Custom schedule")
    end
  end

  describe '#schedule_count' do
    it 'returns count of schedules' do
      trigger = described_class.new(valid_attrs.merge(schedules: ["0 2 * * *", "0 14 * * *"]))
      expect(trigger.schedule_count).to eq(2)
    end

    it 'returns 1 for single schedule' do
      trigger = described_class.new(valid_attrs)
      expect(trigger.schedule_count).to eq(1)
    end
  end

  describe 'validation' do
    it 'rejects empty schedules array' do
      expect {
        described_class.new(valid_attrs.merge(schedules: []))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects empty script_name' do
      expect {
        described_class.new(valid_attrs.merge(script_name: ""))
      }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts script_name at max length' do
      trigger = described_class.new(valid_attrs.merge(script_name: "x" * 256))
      expect(trigger.script_name.length).to eq(256)
    end

    it 'rejects script_name exceeding max length' do
      expect {
        described_class.new(valid_attrs.merge(script_name: "x" * 257))
      }.to raise_error(Dry::Struct::Error)
    end
  end
end
