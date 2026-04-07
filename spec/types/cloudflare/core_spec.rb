# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/types/cloudflare/core'

RSpec.describe 'Pangea::Resources::Types Cloudflare core types' do
  let(:types) { Pangea::Resources::Types }

  describe 'CloudflareTtl' do
    it 'accepts automatic TTL value of 1' do
      expect(types::CloudflareTtl[1]).to eq(1)
    end

    it 'accepts minimum manual TTL of 60' do
      expect(types::CloudflareTtl[60]).to eq(60)
    end

    it 'accepts maximum manual TTL of 86400' do
      expect(types::CloudflareTtl[86400]).to eq(86400)
    end

    it 'accepts TTL within valid range' do
      expect(types::CloudflareTtl[3600]).to eq(3600)
    end

    it 'rejects TTL of 0' do
      expect { types::CloudflareTtl[0] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects TTL between 2 and 59 (gap between automatic and manual)' do
      expect { types::CloudflareTtl[59] }.to raise_error(Dry::Types::ConstraintError)
      expect { types::CloudflareTtl[2] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects TTL above 86400' do
      expect { types::CloudflareTtl[86401] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects negative TTL' do
      expect { types::CloudflareTtl[-1] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareZoneId' do
    it 'accepts valid 32-character hex ID' do
      expect(types::CloudflareZoneId["a" * 32]).to eq("a" * 32)
    end

    it 'accepts Terraform interpolation strings' do
      expect(types::CloudflareZoneId['${cloudflare_zone.test.id}']).to eq('${cloudflare_zone.test.id}')
    end

    it 'rejects IDs shorter than 32 characters' do
      expect { types::CloudflareZoneId["a" * 31] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects IDs longer than 32 characters' do
      expect { types::CloudflareZoneId["a" * 33] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects IDs with uppercase hex chars' do
      expect { types::CloudflareZoneId["A" * 32] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects IDs with non-hex characters' do
      expect { types::CloudflareZoneId["g" * 32] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects empty string' do
      expect { types::CloudflareZoneId[""] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareAccountId' do
    it 'accepts valid 32-character hex ID' do
      expect(types::CloudflareAccountId["f037e56e89293a057740de681ac9abbe"]).to eq("f037e56e89293a057740de681ac9abbe")
    end

    it 'accepts Terraform interpolation strings' do
      expect(types::CloudflareAccountId['${var.account_id}']).to eq('${var.account_id}')
    end

    it 'rejects non-hex IDs' do
      expect { types::CloudflareAccountId["xyz" + "0" * 29] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareApiToken' do
    it 'accepts 40-character string' do
      expect(types::CloudflareApiToken["a" * 40]).to eq("a" * 40)
    end

    it 'rejects string shorter than 40 characters' do
      expect { types::CloudflareApiToken["a" * 39] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects string longer than 40 characters' do
      expect { types::CloudflareApiToken["a" * 41] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareEmail' do
    it 'accepts valid email' do
      expect(types::CloudflareEmail["user@example.com"]).to eq("user@example.com")
    end

    it 'rejects email without @' do
      expect { types::CloudflareEmail["userexample.com"] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects email without TLD' do
      expect { types::CloudflareEmail["user@example"] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareZonePlan' do
    it 'accepts all valid plans' do
      %w[free pro business enterprise].each do |plan|
        expect(types::CloudflareZonePlan[plan]).to eq(plan)
      end
    end

    it 'rejects invalid plan' do
      expect { types::CloudflareZonePlan['premium'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareZoneType' do
    it 'accepts all valid zone types' do
      %w[full partial secondary].each do |zone_type|
        expect(types::CloudflareZoneType[zone_type]).to eq(zone_type)
      end
    end

    it 'rejects invalid zone type' do
      expect { types::CloudflareZoneType['primary'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareDnsRecordType' do
    it 'accepts all standard DNS record types' do
      %w[A AAAA CNAME TXT MX NS SRV CAA].each do |rtype|
        expect(types::CloudflareDnsRecordType[rtype]).to eq(rtype)
      end
    end

    it 'accepts advanced DNS record types' do
      %w[HTTPS SVCB LOC PTR CERT DNSKEY DS NAPTR SMIMEA SSHFP TLSA URI].each do |rtype|
        expect(types::CloudflareDnsRecordType[rtype]).to eq(rtype)
      end
    end

    it 'rejects invalid record type' do
      expect { types::CloudflareDnsRecordType['INVALID'] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects lowercase record type' do
      expect { types::CloudflareDnsRecordType['a'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflarePriority' do
    it 'accepts minimum priority 0' do
      expect(types::CloudflarePriority[0]).to eq(0)
    end

    it 'accepts maximum priority 65535' do
      expect(types::CloudflarePriority[65535]).to eq(65535)
    end

    it 'rejects negative priority' do
      expect { types::CloudflarePriority[-1] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects priority above 65535' do
      expect { types::CloudflarePriority[65536] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareSslMode' do
    it 'accepts all valid SSL modes' do
      %w[off flexible full strict origin_pull].each do |mode|
        expect(types::CloudflareSslMode[mode]).to eq(mode)
      end
    end

    it 'rejects invalid SSL mode' do
      expect { types::CloudflareSslMode['tls'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CloudflareSecurityLevel' do
    it 'accepts all valid security levels' do
      %w[off essentially_off low medium high under_attack].each do |level|
        expect(types::CloudflareSecurityLevel[level]).to eq(level)
      end
    end

    it 'rejects invalid security level' do
      expect { types::CloudflareSecurityLevel['maximum'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end
end
