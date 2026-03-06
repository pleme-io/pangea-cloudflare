# frozen_string_literal: true
require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/cloudflare_turnstile_widget/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module CloudflareTurnstileWidget
    include Pangea::Resources::ResourceBuilder

    define_resource :cloudflare_turnstile_widget,
      attributes_class: Cloudflare::Types::TurnstileWidgetAttributes,
      outputs: { id: :id, secret: :secret },
      map: [:account_id, :name, :domains, :mode],
      map_present: [:region, :offlabel]
  end
  module Cloudflare
    include CloudflareTurnstileWidget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Cloudflare)
