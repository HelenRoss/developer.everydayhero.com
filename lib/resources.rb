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
        hash = case resource
        when Hash
          h = {}
          resource.each { |k, v| h[k.to_s] = v }
          h
        else Resources.const_get(constantize(resource))
        end

        %(<pre class="highlight"><code class="language-javascript">) +
          pretty_json(hash) + "</code></pre>"
      end

      private

      def constantize resource
        resource.to_s.split('_').map(&:capitalize).join
      end

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
      funds_raised: Money.new('1000', 'au').attributes,
      custom_metric_total: {amount: '100', unit: 'steps'}
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

    LeaderboardData = {
      id: 1,
      amount: Money.new('1000', 'au').attributes,
      name: 'My Leaderboard',
      pages_ids: [1, 2]
    }

    Leaderboard = {
      leaderboard: LeaderboardData
    }

    Leaderboards = {
      leaderboards: [LeaderboardData]
    }

    CampaignLeaderboardData = {
      campaign_id: 'au-1',
      page_ids: [1, 2]
    }

    CampaignLeaderboard = {
      leaderboard: CampaignLeaderboardData
    }

    PageData = {
      amount: {
      cents: 0,
      currency: {
          iso_code: "AUD",
          name: "Australian Dollar",
          symbol: "$"
      }
      },
      cached_offline_amount_cents: 0,
      campaign_uid: "au-1419",
      charity_uid: "au-6",
      expires_at: "2013-08-29T14:00:00Z",
      gift_aid_eligible: false,
      id: 1511,
      invitation_id: nil,
      name: "Tim",
      owner_type: "User",
      owner_uid: 7,
      slug: "tim",
      state: "active",
      target_cents: 70000,
      team_leader_page_uid: nil,
      team_member_uids: [],
      team_uid: nil,
      uid: 1511,
      custom_metric_total: {amount: '100', unit: 'steps'}
    }

    Page = {
      meta: {
        url: "https://TestCampaignForAPI.edherox.com/au/tim"
      },
      page: PageData
    }

    Pages = {
      pages: [PageData]
    }

    TeamPageData = {
      id:2511,
      slug:"my-new-team",
      gift_aid_eligible:false,
      charity_uid:"au-20",
      campaign_uid:"au-305",
      owner_uid:273,
      owner_type:"Team",
      uid:2511,
      state:"active",
      target_cents:50050,
      name:"My New Team",
      team_uid:nil,
      team_member_uids:[2509],
      team_leader_page_uid:2509,
      expires_at:"2015-06-30T00:00:00.000Z",
      amount:{
        cents:0,
        currency:{
          iso_code:"AUD",
          name:"Australian Dollar",
          symbol:"$"
        }
      },
      cached_offline_amount_cents:0,
      campaign_date:nil,
      fitness_activity_overview:{},
      story:"I've created this page because I want to make a difference. I'm inspired by the work of Test Charity for messaging and wanted to support them by raising money as part of my participation in Sandbox2. Please help me help them by giving whatever you can using the 'Give Now' button. The more people that know about Test Charity for messaging, the greater their impact, so please also spread the word by sharing my page with your friends and family. Thank you in advance for your generosity, it means a lot!\n",
      image:{
        original_image_url:"https://dqw0wvb05w98x.cloudfront.net/assets/pages/images/original/missing.gif",
        tiny_image_url:"https://dqw0wvb05w98x.cloudfront.net/assets/pages/images/tiny/missing.gif",
        small_image_url:"https://dqw0wvb05w98x.cloudfront.net/assets/pages/images/small/missing.gif",
        medium_image_url:"https://dqw0wvb05w98x.cloudfront.net/assets/pages/images/medium/missing.gif",
        large_image_url:"https://dqw0wvb05w98x.cloudfront.net/assets/pages/images/large/missing.gif"
      },
      created_at:"2015-04-07T04:33:51.708Z",
      updated_at:"2015-04-07T04:33:51.801Z",
      url:"https://sandbox2.edheroz.com/au/my-new-team",
      invitation_id:nil,
      coordinate:{
        lat:-27.46,
        lon:153.03
      }
    }

    Teampage = {
      page: [TeamPageData]
    }

    InvitationData = {
      id: 1,
      email: 'support@everydayhero.com',
      accepted_at: '2013-04-01T00:00:00Z',
      cancelled_at: nil
    }

    JoinTeamInvitationData = InvitationData.merge \
      team_page_id: 1

    CreateIndividualPageInvitation = {
      create_individual_page_invitation: InvitationData
    }

    JoinTeamInvitation = {
      join_team_invitation: JoinTeamInvitationData
    }

    JoinRequestData = {
      id: 1,
      state: 'pending',
      team_page_id: 1,
      individual_page_id: 1
    }

    JoinRequest = {
      join_request: JoinRequestData
    }

    PassportUserData = {
      uid: 1,
      id: 1,
      name: "joel r",
      nickname: "jo",
      email: "abcdef@everydayhero.com.au",
      phone: "12345",
      profile_image: nil,
      location: "Alderley, Queensland, Australia",
      birthday: "1983-05-21",
      address: "1234 Campbell Terrace, Alderley, Queensland, Australia",
      address_components: {
        street_address: "1234 Campbell Terrace",
        extended_address: nil,
        locality: "Alderley",
        region: "Queensland",
        postal_code: "4051",
        country_name: "Australia"
      },
      address_coordinates: {
        latitude: -27.421,
        longitude: 153.000
      }
    }

    Passportuser = {
      user: [PassportUserData]
    }

    UserData = {
      uid: 1,
      name: "John O'Donnell",
      nickname: 'John',
      email: 'john@example.com',
      phone: '1300798768',
      birthday: '1980-01-13',
      street_address: '87 Wickham Terrace',
      extended_address: nil,
      locality: 'Spring Hill',
      region: 'QLD',
      postal_code: '4006',
      country_name: 'Australia',
      page_ids: [1,2],
    }

    Users = {
      users: [UserData, UserData]
    }

    Tokendata = {
      access_token: "xxxxxxca4e6d9d09f1d6b1330ccf97d862a7b42e87c737195f90e508d0xxxxxx",
      token_type: "bearer",
      expires_in: nil,
      refresh_token: nil,
      scope: "",
    }

    TeamData = {
      uid: 1,
      name: "Team Example"
    }

    Team = {
      team: TeamData
    }
  end
end

include EverydayHero::Resources::Helpers
