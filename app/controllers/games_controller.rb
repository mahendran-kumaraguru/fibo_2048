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

  def save_game
    @game = Game.find(params[:id])
    game_data = []
    params[:grid_data].each do |gd|
      game_data << gd.last
    end
    @game.data = game_data
    @game.score = params[:score].to_i
    user = @game.user
    if user.high_score < @game.score
      user.high_score = @game.score
      user.save
    end
    @game.free_size = params[:free_size].to_i
    @game.is_complete = (params[:free_size].to_i == 0)
    if not @game.save
      flash[:erros] = "Failed to save game"
    end
    redirect_to my_games_path

  end

  private def game_params
  	params.require(:game).permit(:grid)
  end
end
