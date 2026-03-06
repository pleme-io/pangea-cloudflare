# pangea-cloudflare

Cloudflare provider bindings for the Pangea infrastructure DSL.

## Overview

Provides 200 typed Terraform resource functions for Cloudflare, covering DNS, zones,
Workers, R2, Zero Trust, tunnels, load balancing, WAF, Pages, and email routing.
Each resource uses Dry::Struct validation and compiles to Terraform JSON via
terraform-synthesizer. Built on pangea-core.

## Installation

```ruby
gem 'pangea-cloudflare', '~> 0.1'
```

## Usage

```ruby
require 'pangea-cloudflare'

template :dns do
  provider :cloudflare do
  end

  zone = cloudflare_zone(:example, { zone: "example.com", account_id: var(:account_id) })
  cloudflare_record(:root, { zone_id: zone.id, name: "@", type: "A", content: "1.2.3.4" })
end
```

## Development

```bash
nix develop
bundle exec rspec
```

## License

Apache-2.0
