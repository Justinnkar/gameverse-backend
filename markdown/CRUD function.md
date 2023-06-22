### CRUD functions!

#### index

add test in ***spec/requests/games_spec.rb***

```ruby
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
```

run rspec to get good fail
-$ `rspec spec/requests/games_spec.rb`

add index method in ***app/controllers/games_controller.rb***

```ruby
def index
    games = Game.all
    render json: games
end
```

run rspec to pass test
-$ `rspec spec/requests/games_spec.rb`


#### Create

add test in ***spec/requests/games_spec.rb***

```ruby
describe "POST /create" do

    it "creates a game" do
      game_params = {
          game: {
          title: 'League of Legends',
          rating: 9.6,
          platform: 'Windows PC, Mac OS',
          genre: 'Multiplayer Online Battle Arena (MOBA)',
          developer: 'Riot Games',
          image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
          summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
          release_date: '2009-10-27',
          user_id: user.id
          }
      }

      post '/games', params: game_params

      expect(response).to have_http_status(200)

      game= Game.first

      expect(game.title).to eq 'League of Legends'
    end

    it "doesn't create a game without a title" do
      game_params = {
          game: {
          rating: 9.6,
          platform: 'Windows PC, Mac OS',
          genre: 'Multiplayer Online Battle Arena (MOBA)',
          developer: 'Riot Games',
          image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
          summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
          release_date: '2009-10-27',
          user_id: user.id
          }
      }

      post '/games', params: game_params

      expect(response.status).to eq 422

      json = JSON.parse(response.body)

      expect(json['title']).to include "can't be blank"
    end

    it "doesn't create a game without a rating" do
      game_params = {
          game: {
          title: '9.6',
          platform: 'Windows PC, Mac OS',
          genre: 'Multiplayer Online Battle Arena (MOBA)',
          developer: 'Riot Games',
          image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
          summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
          release_date: '2009-10-27',
          user_id: user.id
          }
      }

      post '/games', params: game_params

      expect(response.status).to eq 422

      json = JSON.parse(response.body)

      expect(json['rating']).to include "can't be blank"
    end

    it "doesn't create a game without a platform" do
      game_params = {
          game: {
          rating: 9.6,
          title: 'Windows PC, Mac OS',
          genre: 'Multiplayer Online Battle Arena (MOBA)',
          developer: 'Riot Games',
          image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
          summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
          release_date: '2009-10-27',
          user_id: user.id
          }
      }

      post '/games', params: game_params

      expect(response.status).to eq 422

      json = JSON.parse(response.body)

      expect(json['platform']).to include "can't be blank"
    end


    it "doesn't create a game without a genre" do
      game_params = {
          game: {
          rating: 9.6,
          platform: 'Windows PC, Mac OS',
          title: 'Multiplayer Online Battle Arena (MOBA)',
          developer: 'Riot Games',
          image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
          summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
          release_date: '2009-10-27',
          user_id: user.id
          }
      }

      post '/games', params: game_params

      expect(response.status).to eq 422

      json = JSON.parse(response.body)

      expect(json['genre']).to include "can't be blank"
    end

    it "doesn't create a game without a developer" do
      game_params = {
          game: {
          rating: 9.6,
          platform: 'Windows PC, Mac OS',
          genre: 'Multiplayer Online Battle Arena (MOBA)',
          title: 'Riot Games',
          image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
          summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
          release_date: '2009-10-27',
          user_id: user.id
          }
      }

      post '/games', params: game_params

      expect(response.status).to eq 422

      json = JSON.parse(response.body)

      expect(json['developer']).to include "can't be blank"
    end

    it "doesn't create a game without a image" do
      game_params = {
          game: {
          rating: 9.6,
          platform: 'Windows PC, Mac OS',
          genre: 'Multiplayer Online Battle Arena (MOBA)',
          developer: 'Riot Games',
          title: 'x',
          summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
          release_date: '2009-10-27',
          user_id: user.id
          }
      }

      post '/games', params: game_params

      expect(response.status).to eq 422

      json = JSON.parse(response.body)

      expect(json['image']).to include "can't be blank"
    end

    it "doesn't create a game without a summary" do
      game_params = {
          game: {
          rating: 9.6,
          platform: 'Windows PC, Mac OS',
          genre: 'Multiplayer Online Battle Arena (MOBA)',
          developer: 'Riot Games',
          image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
          title: "League of Legends", 
          release_date: '2009-10-27',
          user_id: user.id
          }
      }

      post '/games', params: game_params

      expect(response.status).to eq 422

      json = JSON.parse(response.body)

      expect(json['summary']).to include "can't be blank"
    end

    it "doesn't create a game without a release date" do
      game_params = {
          game: {
          rating: 9.6,
          platform: 'Windows PC, Mac OS',
          genre: 'Multiplayer Online Battle Arena (MOBA)',
          developer: 'Riot Games',
          image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
          summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
          title: '2009',
          user_id: user.id
          }
      }

      post '/games', params: game_params

      expect(response.status).to eq 422

      json = JSON.parse(response.body)

      expect(json['release_date']).to include "can't be blank"
    end

    it "doesn't create a game without a user" do
      game_params = {
          game: {
          rating: 9.6,
          platform: 'Windows PC, Mac OS',
          genre: 'Multiplayer Online Battle Arena (MOBA)',
          developer: 'Riot Games',
          image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
          summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
          release_date: '2009-10-27',
          title: 'test'
          }
      }

      post '/games', params: game_params

      expect(response.status).to eq 422

      json = JSON.parse(response.body)

      expect(json['user_id']).to include "can't be blank"
    end
```
run rspec to get good fail
-$ `rspec spec/requests/games_spec.rb`

add create method and strong params in ***app/controllers/games_controller.rb***

```ruby
def create
    game = Game.create(game_params)
    if game.valid?
        render json: game
        else
        render json: game.errors, status: 422
    end
end
```

```ruby
private

def game_params
    params.require(:game).permit(:title, :rating, :platform, :genre, :developer, :image, :summary, :release_date, :user_id)
end
```

run rspec to pass test
-$ `rspec spec/requests/games_spec.rb`