require 'yajl/json_gem'

module EverydayHero
  module Resources
    module Helpers
      # Return a JSON representation of a resource or an array of
      # resources.
      #
      # example:
      #   json :campaign  # => {'campaign': {}}
      #   json :campaigns # => {'campaigns': [{}]}
      def json resource
        hash = Resources.const_get resource.capitalize

        %(<pre class="highlight"><code class="language-javascript">) +
          pretty_json(hash) + "</code></pre>"
      end

      private

      def pretty_json hash
        JSON.pretty_generate hash
      end
    end

    class Money
      ISO_CODES = {'au' => 'AUD'}
      SYMBOLS   = {'au' => '$'}
      NAMES     = {'au' => 'Australian Dollar'}

      def initialize cents, country
        @cents, @country = cents, country
      end

      def attributes
        {
          cents: @cents,
          currency: {
            iso_code: ISO_CODES.fetch(@country),
            symbol: SYMBOLS.fetch(@country),
            name: NAMES.fetch(@country)
          }
        }
      end
    end

    CampaignData = {
      id: 'au-1',
      name: 'Run Melbourne',
      slug: 'run-melbourne',
      start_at: '2013-04-01T00:00:00Z',
      finish_at: '2013-04-01T00:00:00Z',
      country_code: 'au',
      registration_url: 'http://',
      banner_url: '',
      funds_raised: Money.new('1000', 'au').attributes
    }

    Campaign = {
      campaign: CampaignData
    }

    Campaigns = {
      campaigns: [CampaignData]
    }

    CharityData = {
      id: 'au-1',
      name: 'Starlight',
      slug: 'starlight',
      country_code: 'au',
      description: nil,
      gift_aid: false,
      logo_url: 'http://'
    }

    Charity = {
      charity: CharityData
    }

    Charities = {
      charities: [CharityData]
    }
  end
end

include EverydayHero::Resources::Helpers