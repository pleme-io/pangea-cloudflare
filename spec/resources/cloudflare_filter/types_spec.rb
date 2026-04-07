# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_filter/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::FilterAttributes do
  let(:zone_id) { "a" * 32 }

  let(:valid_attrs) do
    { zone_id: zone_id, expression: "ip.src eq 1.2.3.4" }
  end

  describe 'computed properties' do
    it '#is_active? returns true when not paused' do
      filter = described_class.new(valid_attrs)
      expect(filter.is_active?).to be true
    end

    it '#is_active? returns false when paused' do
      filter = described_class.new(valid_attrs.merge(paused: true))
      expect(filter.is_active?).to be false
    end

    it '#is_paused? returns false by default' do
      filter = described_class.new(valid_attrs)
      expect(filter.is_paused?).to be false
    end

    it '#has_description? returns false when no description' do
      filter = described_class.new(valid_attrs)
      expect(filter.has_description?).to be false
    end

    it '#has_description? returns true when description present' do
      filter = described_class.new(valid_attrs.merge(description: "Block bad IPs"))
      expect(filter.has_description?).to be true
    end

    it '#expression_length returns length of expression' do
      filter = described_class.new(valid_attrs)
      expect(filter.expression_length).to eq("ip.src eq 1.2.3.4".length)
    end
  end
end
