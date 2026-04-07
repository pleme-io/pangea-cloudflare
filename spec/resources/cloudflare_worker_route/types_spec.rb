# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_worker_route/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::WorkerRouteAttributes do
  let(:zone_id) { "a" * 32 }

  let(:valid_attrs) do
    { zone_id: zone_id, pattern: "example.com/*" }
  end

  describe '#is_catch_all?' do
    it 'returns true for wildcard path' do
      route = described_class.new(valid_attrs)
      expect(route.is_catch_all?).to be true
    end

    it 'returns false for specific path' do
      route = described_class.new(valid_attrs.merge(pattern: "example.com/api"))
      expect(route.is_catch_all?).to be false
    end
  end

  describe '#has_script?' do
    it 'returns true when script_name is set' do
      route = described_class.new(valid_attrs.merge(script_name: "my-worker"))
      expect(route.has_script?).to be true
    end

    it 'returns false when script_name is nil' do
      route = described_class.new(valid_attrs)
      expect(route.has_script?).to be false
    end
  end

  describe '#matches_subdomain?' do
    it 'returns true for subdomain wildcard pattern' do
      route = described_class.new(valid_attrs.merge(pattern: "*.example.com/*"))
      expect(route.matches_subdomain?).to be true
    end

    it 'returns false for root domain pattern' do
      route = described_class.new(valid_attrs)
      expect(route.matches_subdomain?).to be false
    end
  end
end
