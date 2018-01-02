class GamesController < ApplicationController
  def new
  	@game = Game.new
  end

  def create
  	@game = Game.new(game_params)
  	grid = game_params[:grid].to_i
  	@game.free_size = grid * grid
  	@game.data = Array.new(grid){Array.new(grid, 0)}
  	@game.user = User.find(session[:user_id])
  	if @game.save
  		redirect_to game_path(@game.id)
  	else
  		redirect_to :back, :notice => @game.errors.full_messages.first
  	end
  end

  def show
  	@game = Game.find(params[:id])
  end

  private def game_params
  	params.require(:game).permit(:grid)
  end
end
