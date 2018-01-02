class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	puts @user.inspect
  	if @user.save
  		redirect_to login_path, :notice => "Registered Successfully"
  	else
  		redirect_to :back, :notice => @user.errors.full_messages.first
  	end
  end

  def show_games
    @games = Game.where(user_id: session[:user_id]).order("score desc").order("grid desc").order("updated_at desc").limit(10)
  end

  private def user_params
  	params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
