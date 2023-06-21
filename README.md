### Create rails app

-$ `rails new gameverse-app-backend -d postgresql -T`
-$ `cd gameverse-app-backend`
-$ `rails db:create`
-$ `bundle add rspec-rails`
-$ `rails generate rspec:install`

### Device

-$ `bundle add devise`
-$ `rails generate devise:install`
-$ `rails generate devise User`
-$ `rails db:migrate`

### JWT

#### adding to Gemfile:

gem 'devise-jwt'
gem 'rack-cors'

-$ `bundle`

### CORS 

#### create a new file in config/initializers named cors.rb
add code:

```ruby
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3001'
    resource '*',
    headers: ["Authorization"],
    expose: ["Authorization"],
    methods: [:get, :post, :put, :patch, :delete, :options, :head],
    max_age: 600
  end
end
```

### Resource

```bash
rails g resource Game title:string rating:float platform:string genre:string developer:string image:text summary: text release_date:date
```

-$ `rails db:migrate` 

-$ `rails g migration add_user_id_for_games`

in migration file:

```ruby
add_column :games, :user_id, :integer
```

-$ `rails db:migrate` 

Add relationship to user and game.

in model/game.rb

add:
belongs_to :user


in model/user.rb

add:
has_many :games


### Seeds

add user to seed:

```ruby
user1 = User.where(email: "test1@example.com").first_or_create(password: "password", password_confirmation: "password")
user2 = User.where(email: "test2@example.com").first_or_create(password: "password", password_confirmation: "password")
```

add games to seed:
```ruby
games_catalog = [
  {
    title: 'League of Legends',
    rating: 9.6,
    platform: 'Windows PC, Mac OS',
    genre: 'Multiplayer Online Battle Arena (MOBA)',
    developer: 'Riot Games',
    image: 'https://www.leagueoflegends.com/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg',
    summary: "League of Legends is one of the world's most popular video games, developed by Riot Games. It features a team-based competitive game mode based on strategy and outplaying opponents. Players work with their team to break the enemy Nexus before the enemy team breaks theirs.", 
    release_date: '2009-10-27',
  },
  {
    title: 'Diablo IV',
    rating: 9.6,
    platform: 'Windows PC, PS4, PS5, Xbox One, Xbox Series X/S',
    genre: 'Action role playing',
    developer: 'Blizzard',
    image: 'https://blz-contentstack-images.akamaized.net/v3/assets/blt77f4425de611b362/blt6d7b0fd8453e72b9/646e720a71d9db111a265e8c/d4-open-graph_001.jpg',
    summary: "Diablo IV is the fourth main installment in the Diablo series. The story is centered around Lilith, Mephisto's daughter, who has been summoned into Sanctuary.", 
    release_date: '2023-06-06'
  }
]
```

add behavier:

```ruby
games_catalog.each do |game|
  user1.games.create(game)
  puts "creating game #{game[:title]}"
end
```

### More devise setup

in **config/environments/development.rb**
add:

```ruby
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

in **config/initializers/devise.rb**
find: 
```ruby
config.sign_out_via = :delete 
```
replace with: 
```ruby
config.sign_out_via = :get
```

#### Uncomment the config.navigational_formats line and remove the contents of the array:
```ruby
config.navigational_formats = []
```

create registrations and sessions controllers for signups and logins.

```bash
$ rails g devise:controllers users -c registrations sessions
```
in **app/controllers/users/registrations_controller.rb**

```ruby
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    build_resource(sign_up_params)
    resource.save
    sign_in(resource_name, resource)
    render json: resource
  end
end
```

in **app/controllers/users/sessions_controller.rb**

```ruby
class Users::SessionsController < Devise::SessionsController
  respond_to :json
  private
  def respond_with(resource, _opts = {})
    render json: resource
  end
  def respond_to_on_destroy
    render json: { message: "Logged out." }
  end
end
```

update the devise routes:
in **config/routes.rb**

```ruby
Rails.application.routes.draw do
  resources :apartments
  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
end
```

### JWT Secret Key 

```bash
$ bundle exec rake secret
```
copy the newly-generated key. (send in slack)

```bash
$ EDITOR="code --wait" bin/rails credentials:edit
```

new file will open with vs code

add code below secret_key_base:

```ruby
jwt_secret_key: <newly-created secret key>
```

ctl + c to encrypt and save the file.

### More config for Devise and JWT

in **config/initializers/devise.rb**

```ruby
config.jwt do |jwt|
  jwt.secret = ENV['DEVISE_JWT_SECRET_KEY']
  jwt.dispatch_requests = [
    ['POST', %r{^/login$}],
  ]
  jwt.revocation_requests = [
    ['DELETE', %r{^/logout$}]
  ]
  jwt.expiration_time = 5.minutes.to_i
end
```

### Revocation with JWT

```bash
$ rails generate model jwt_denylist
```

in migration file:

```ruby
def change
  create_table :jwt_denylist do |t|
    t.string :jti, null: false
    t.datetime :exp, null: false
  end
  add_index :jwt_denylist, :jti
end
```
-$ `rails db:migrate`

update user model:

in **app/models/user.rb**

```ruby
devise  :database_authenticatable, :registerable,
        :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
```

### Disable Authenticity Token

in **app/controllers/application_controller.rb**
```ruby
skip_before_action :verify_authenticity_token
```
