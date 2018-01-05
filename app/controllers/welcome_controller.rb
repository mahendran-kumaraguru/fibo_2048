class WelcomeController < ApplicationController
  def index
  	if session[:user_id]
  		redirect_to my_games_path
  	else
  		redirect_to login_path
  	end
  end
end
