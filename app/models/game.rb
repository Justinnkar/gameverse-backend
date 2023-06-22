class Game < ApplicationRecord
    belongs_to :user
    validates :title, :rating, :platform, :genre, :developer, :image, :summary, :release_date, presence: true
end
