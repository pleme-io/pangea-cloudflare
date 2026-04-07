# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/cloudflare_worker_script/types'

RSpec.describe Pangea::Resources::Cloudflare::Types::WorkerScriptAttributes do
  let(:account_id) { "f037e56e89293a057740de681ac9abbe" }

  let(:valid_attrs) do
    { account_id: account_id, name: "my-worker", content: "addEventListener('fetch', e => e.respondWith(new Response('OK')))" }
  end

  describe 'custom validation' do
    it 'rejects empty content' do
      expect {
        described_class.new(valid_attrs.merge(content: "   "))
      }.to raise_error(Dry::Struct::Error, /content cannot be empty/)
    end

    it 'rejects invalid name format with spaces' do
      expect {
        described_class.new(valid_attrs.merge(name: "my worker"))
      }.to raise_error(Dry::Struct::Error, /name must contain only alphanumeric/)
    end

    it 'rejects name with special characters' do
      expect {
        described_class.new(valid_attrs.merge(name: "my@worker!"))
      }.to raise_error(Dry::Struct::Error, /name must contain only alphanumeric/)
    end

    it 'accepts name with hyphens and underscores' do
      worker = described_class.new(valid_attrs.merge(name: "my-worker_v2"))
      expect(worker.name).to eq("my-worker_v2")
    end
  end

  describe 'computed properties' do
    it '#is_module_worker? returns true when module is true' do
      worker = described_class.new(valid_attrs.merge(module: true))
      expect(worker.is_module_worker?).to be true
    end

    it '#is_module_worker? returns false by default' do
      worker = described_class.new(valid_attrs)
      expect(worker.is_module_worker?).to be false
    end

    it '#is_service_worker? returns true by default' do
      worker = described_class.new(valid_attrs)
      expect(worker.is_service_worker?).to be true
    end

    it '#is_service_worker? returns false when module is true' do
      worker = described_class.new(valid_attrs.merge(module: true))
      expect(worker.is_service_worker?).to be false
    end

    it '#has_kv_bindings? returns false when no bindings' do
      worker = described_class.new(valid_attrs)
      expect(worker.has_kv_bindings?).to be false
    end

    it '#has_kv_bindings? returns true when bindings present' do
      worker = described_class.new(valid_attrs.merge(
        kv_namespace_bindings: [{ name: "KV", namespace_id: "a" * 32 }]
      ))
      expect(worker.has_kv_bindings?).to be true
    end

    it '#has_secrets? returns false when no secret bindings' do
      worker = described_class.new(valid_attrs)
      expect(worker.has_secrets?).to be false
    end

    it '#has_secrets? returns true when secret bindings present' do
      worker = described_class.new(valid_attrs.merge(
        secret_text_bindings: [{ name: "API_KEY", text: "secret123" }]
      ))
      expect(worker.has_secrets?).to be true
    end
  end

  describe 'default values' do
    let(:worker) { described_class.new(valid_attrs) }

    it 'defaults module to false' do
      expect(worker.module).to be false
    end

    it 'defaults compatibility_date to nil' do
      expect(worker.compatibility_date).to be_nil
    end

    it 'defaults compatibility_flags to empty array' do
      expect(worker.compatibility_flags).to eq([])
    end

    it 'defaults kv_namespace_bindings to empty array' do
      expect(worker.kv_namespace_bindings).to eq([])
    end

    it 'defaults plain_text_bindings to empty array' do
      expect(worker.plain_text_bindings).to eq([])
    end

    it 'defaults secret_text_bindings to empty array' do
      expect(worker.secret_text_bindings).to eq([])
    end

    it 'defaults d1_database_bindings to empty array' do
      expect(worker.d1_database_bindings).to eq([])
    end

    it 'defaults queue_bindings to empty array' do
      expect(worker.queue_bindings).to eq([])
    end
  end

  describe 'bindings' do
    it 'accepts multiple KV namespace bindings' do
      worker = described_class.new(valid_attrs.merge(
        kv_namespace_bindings: [
          { name: "CACHE", namespace_id: "a" * 32 },
          { name: "SESSIONS", namespace_id: "b" * 32 }
        ]
      ))
      expect(worker.kv_namespace_bindings.length).to eq(2)
    end

    it 'accepts D1 database bindings' do
      worker = described_class.new(valid_attrs.merge(
        d1_database_bindings: [
          { name: "DB", database_id: "a" * 32 }
        ]
      ))
      expect(worker.d1_database_bindings.length).to eq(1)
    end

    it 'accepts queue bindings' do
      worker = described_class.new(valid_attrs.merge(
        queue_bindings: [
          { name: "TASKS", queue_name: "task-queue" }
        ]
      ))
      expect(worker.queue_bindings.length).to eq(1)
    end
  end
end
