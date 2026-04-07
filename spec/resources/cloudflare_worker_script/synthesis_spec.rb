# frozen_string_literal: true
require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/cloudflare_worker_script/resource'
require 'pangea/resources/cloudflare_worker_script/types'

RSpec.describe 'cloudflare_worker_script synthesis' do
  include Pangea::Resources::Cloudflare

  let(:synthesizer) { TerraformSynthesizer.new }
  let(:account_id) { "f037e56e89293a057740de681ac9abbe" }
  let(:worker_content) { "export default { async fetch(request) { return new Response('Hello World'); } }" }

  describe 'terraform synthesis' do
    it 'synthesizes basic worker script' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_worker_script(:test, {
          account_id: "f037e56e89293a057740de681ac9abbe",
          name: "my-worker",
          content: "export default { async fetch(request) { return new Response('Hello World'); } }"
        })
      end

      result = synthesizer.synthesis
      worker = result[:resource][:cloudflare_worker_script][:test]

      expect(worker[:account_id]).to eq(account_id)
      expect(worker[:name]).to eq("my-worker")
      expect(worker[:content]).to include("Hello World")
    end

    it 'synthesizes worker with module format' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_worker_script(:module_worker, {
          account_id: "f037e56e89293a057740de681ac9abbe",
          name: "module-worker",
          content: "export default { async fetch() { return new Response('OK') } }",
          module: true
        })
      end

      result = synthesizer.synthesis
      worker = result[:resource][:cloudflare_worker_script][:module_worker]

      expect(worker[:module]).to be true
    end

    it 'synthesizes worker with compatibility settings' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_worker_script(:compat_worker, {
          account_id: "f037e56e89293a057740de681ac9abbe",
          name: "compat-worker",
          content: "export default { async fetch() { return new Response('OK') } }",
          compatibility_date: "2024-01-01",
          compatibility_flags: ["nodejs_compat"]
        })
      end

      result = synthesizer.synthesis
      worker = result[:resource][:cloudflare_worker_script][:compat_worker]

      expect(worker[:compatibility_date]).to eq("2024-01-01")
      expect(worker[:compatibility_flags]).to eq(["nodejs_compat"])
    end

    it 'synthesizes worker with KV namespace bindings' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_worker_script(:kv_worker, {
          account_id: "f037e56e89293a057740de681ac9abbe",
          name: "kv-worker",
          content: "export default { async fetch() { return new Response('OK') } }",
          kv_namespace_bindings: [
            { name: "CACHE", namespace_id: "b" * 32 }
          ]
        })
      end

      result = synthesizer.synthesis
      worker = result[:resource][:cloudflare_worker_script][:kv_worker]

      expect(worker[:kv_namespace_binding]).to be_an(Array)
      expect(worker[:kv_namespace_binding].length).to eq(1)
      expect(worker[:kv_namespace_binding][0][:name]).to eq("CACHE")
    end

    it 'synthesizes worker with plain text bindings' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_worker_script(:env_worker, {
          account_id: "f037e56e89293a057740de681ac9abbe",
          name: "env-worker",
          content: "export default { async fetch() { return new Response('OK') } }",
          plain_text_bindings: [
            { name: "API_URL", text: "https://api.example.com" }
          ]
        })
      end

      result = synthesizer.synthesis
      worker = result[:resource][:cloudflare_worker_script][:env_worker]

      expect(worker[:plain_text_binding]).to be_an(Array)
      expect(worker[:plain_text_binding][0][:name]).to eq("API_URL")
      expect(worker[:plain_text_binding][0][:text]).to eq("https://api.example.com")
    end

    it 'synthesizes worker with secret text bindings' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_worker_script(:secret_worker, {
          account_id: "f037e56e89293a057740de681ac9abbe",
          name: "secret-worker",
          content: "export default { async fetch() { return new Response('OK') } }",
          secret_text_bindings: [
            { name: "API_KEY", text: "super-secret-key" }
          ]
        })
      end

      result = synthesizer.synthesis
      worker = result[:resource][:cloudflare_worker_script][:secret_worker]

      expect(worker[:secret_text_binding]).to be_an(Array)
      expect(worker[:secret_text_binding][0][:name]).to eq("API_KEY")
    end

    it 'synthesizes worker with D1 database bindings' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_worker_script(:d1_worker, {
          account_id: "f037e56e89293a057740de681ac9abbe",
          name: "d1-worker",
          content: "export default { async fetch() { return new Response('OK') } }",
          d1_database_bindings: [
            { name: "DB", database_id: "c" * 32 }
          ]
        })
      end

      result = synthesizer.synthesis
      worker = result[:resource][:cloudflare_worker_script][:d1_worker]

      expect(worker[:d1_database_binding]).to be_an(Array)
      expect(worker[:d1_database_binding][0][:name]).to eq("DB")
    end

    it 'synthesizes worker with queue bindings' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_worker_script(:queue_worker, {
          account_id: "f037e56e89293a057740de681ac9abbe",
          name: "queue-worker",
          content: "export default { async fetch() { return new Response('OK') } }",
          queue_bindings: [
            { name: "TASKS", queue_name: "task-queue" }
          ]
        })
      end

      result = synthesizer.synthesis
      worker = result[:resource][:cloudflare_worker_script][:queue_worker]

      expect(worker[:queue_binding]).to be_an(Array)
      expect(worker[:queue_binding][0][:name]).to eq("TASKS")
      expect(worker[:queue_binding][0][:queue_name]).to eq("task-queue")
    end

    it 'synthesizes worker with multiple binding types' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Cloudflare
        cloudflare_worker_script(:full_worker, {
          account_id: "f037e56e89293a057740de681ac9abbe",
          name: "full-featured",
          content: "export default { async fetch() { return new Response('OK') } }",
          module: true,
          kv_namespace_bindings: [{ name: "KV", namespace_id: "b" * 32 }],
          secret_text_bindings: [{ name: "SECRET", text: "val" }],
          d1_database_bindings: [{ name: "DB", database_id: "c" * 32 }]
        })
      end

      result = synthesizer.synthesis
      worker = result[:resource][:cloudflare_worker_script][:full_worker]

      expect(worker[:module]).to be true
      expect(worker[:kv_namespace_binding]).to be_an(Array)
      expect(worker[:secret_text_binding]).to be_an(Array)
      expect(worker[:d1_database_binding]).to be_an(Array)
    end
  end
end
