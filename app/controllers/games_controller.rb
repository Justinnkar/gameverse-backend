class GamesController < ApplicationController

    def index
        games = Game.all
        render json: games
    end

    def create
        game = Game.create(game_params)
        if game.valid?
          render json: game
         else
           render json: game.errors, status: 422
        end
    end

    private

    def game_params
      params.require(:game).permit(:title, :rating, :platform, :genre, :developer, :image, :summary, :release_date, :user_id)
    end


end
