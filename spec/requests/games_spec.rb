require 'rails_helper'

RSpec.describe "Games", type: :request do

  describe "GET /index" do
    it "gets a list of games" do
      Game.create(
        title: 'League of Legends',
        rating: 9.6,
        platform: 'Windows PC, Mac OS',
        genre: 'Multiplayer Online Battle Arena (MOBA)',
        developer: 'Riot Games',
        image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
        summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
        release_date: '2009-10-27'
      )

      # Make a request
      get '/games'

      game = JSON.parse(response.body)
      expect(response).to have_http_status(200)
    end
  end
end
