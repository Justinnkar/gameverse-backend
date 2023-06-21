user1 = User.where(email: "test1@example.com").first_or_create(password: "password", password_confirmation: "password")


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

games_catalog.each do |game|
  user1.games.create(game)
  puts "creating game #{game[:title]}"
end