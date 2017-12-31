class LeaderboardController < ApplicationController
  def show
  	@leaders = User.select(:email, :high_score).order('high_score desc').limit(10)
  end
end
