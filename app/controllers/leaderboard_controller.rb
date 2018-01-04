class LeaderboardController < ApplicationController
  def show
  	@leaders = User.select(:email, :high_score).order('high_score desc').limit(10)
  	@user = User.select(:email, :high_score).find(session[:user_id])
  	@leaders[-1] = @user if not @leaders.collect(&:email).include?(@user.email)
  	puts @leaders.inspect
  end
end
