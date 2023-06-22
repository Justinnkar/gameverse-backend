### Validations

#### Add test for all attribute and create test user for game in spec file
in ***spec/models/game_spec.rb***

```ruby
require 'rails_helper'

require 'rails_helper'

RSpec.describe Game, type: :model do

    let(:user) { User.create(
        email: 'test@example.com',
        password: 'password'
        )
    }


  it "should validate game title" do
    game = Game.create(
      title: nil,
      rating: 9.6,
      platform: 'Windows PC, Mac OS',
      genre: 'Multiplayer Online Battle Arena (MOBA)',
      developer: 'Riot Games',
      image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
      summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
      release_date: '2009-10-27',
      user_id: user.id
    )
    expect(game.errors[:title]).to_not be_empty
  end

  it "should validate game rating" do
    game = Game.create(
      title: 'League of Legends',
      rating: nil,
      platform: 'Windows PC, Mac OS',
      genre: 'Multiplayer Online Battle Arena (MOBA)',
      developer: 'Riot Games',
      image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
      summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
      release_date: '2009-10-27',
      user_id: user.id
    )
    expect(game.errors[:rating]).to_not be_empty
  end

  it "should validate game platform" do
    game = Game.create(
      title: 'League of Legends',
      rating: 9.6,
      platform: nil,
      genre: 'Multiplayer Online Battle Arena (MOBA)',
      developer: 'Riot Games',
      image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
      summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
      release_date: '2009-10-27',
      user_id: user.id
    )
    expect(game.errors[:platform]).to_not be_empty
  end

  it "should validate game genre" do
    game = Game.create(
      title: 'League of Legends',
      rating: 9.6,
      platform: 'Windows PC, Mac OS',
      genre: nil,
      developer: 'Riot Games',
      image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
      summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
      release_date: '2009-10-27',
      user_id: user.id
    )
    expect(game.errors[:genre]).to_not be_empty
  end

  it "should validate game developer" do
    game = Game.create(
      title: 'League of Legends',
      rating: 9.6,
      platform: 'Windows PC, Mac OS',
      genre: 'Multiplayer Online Battle Arena (MOBA)',
      developer: nil,
      image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
      summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
      release_date: '2009-10-27',
      user_id: user.id
    )
    expect(game.errors[:developer]).to_not be_empty
  end

  it "should validate game image" do
    game = Game.create(
      title: 'League of Legends',
      rating: 9.6,
      platform: 'Windows PC, Mac OS',
      genre: 'Multiplayer Online Battle Arena (MOBA)',
      developer: 'nil',
      image: nil,
      summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
      release_date: '2009-10-27',
      user_id: 1
    )
    expect(game.errors[:image]).to_not be_empty
  end

  it "should validate game summary" do
    game = Game.create(
      title: 'League of Legends',
      rating: 9.6,
      platform: 'Windows PC, Mac OS',
      genre: 'Multiplayer Online Battle Arena (MOBA)',
      developer: 'nil',
      image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
      summary: nil, 
      release_date: '2009-10-27',
      user_id: user.id
    )
    expect(game.errors[:summary]).to_not be_empty
  end

  it "should validate game release_date" do
    game = Game.create(
      title: 'League of Legends',
      rating: 9.6,
      platform: 'Windows PC, Mac OS',
      genre: 'Multiplayer Online Battle Arena (MOBA)',
      developer: 'nil',
      image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
      summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
      release_date: nil,
      user_id: user.id
    )
    expect(game.errors[:release_date]).to_not be_empty
  end

  it "should validate user_id" do
    game = Game.create(
      title: 'League of Legends',
      rating: 9.6,
      platform: 'Windows PC, Mac OS',
      genre: 'Multiplayer Online Battle Arena (MOBA)',
      developer: 'nil',
      image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
      summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
      release_date: '2009-10-27',
      user_id: nil
    )
    expect(game.errors[:user_id]).to_not be_empty
  end

end

```

run rspec for good fails:
-$ `rspec spec/models/game_spec.rb`

#### add validation for game model

in: ***app/models/game.rb***

```ruby
validates :title, :rating, :platform, :genre, :developer, :image, :summary, :release_date, :user_id, presence: true
```
run rspec to pass
-$ `rspec spec/models/game_spec.rb`

#### add test to user model:

in ***spec/models/user_spec.rb***

```ruby
require 'rails_helper'

RSpec.describe User, type: :model do

  it "should validate user email" do
    user = User.create(
      email: nil,
      password: "password"
    )
    expect(user.errors[:email]).to_not be_empty
  end

  it "should validate password" do
    user = User.create(
      email: "test1@example.com",
      password: nil
    )
    expect(user.errors[:password]).to_not be_empty
  end

end
```

run rspec for good fails:
-$ `rspec spec/models/user_spec.rb`

#### add validation in user model:

in ***app/models/user.rb***

```ruby
validates :email, :password, presence: true
```

run rspec to pass
-$ `rspec spec/models/user_spec.rb`