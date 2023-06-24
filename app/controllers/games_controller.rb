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

  def update
    game = Game.find(params[:id])
    if game.update(game_params)
      render json: game
    else
      render json: game.errors, status: :unprocessable_entity
    end
  end

  def destroy
    games = Game.all
    game = Game.find(params[:id])
    if game.destroy
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
