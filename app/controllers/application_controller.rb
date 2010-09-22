class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :initialize_user

  def initialize_user
    if session[:oauth_token] && session[:oauth_secret]
      access_token = OAuth::AccessToken.new(consumer, session[:oauth_token], session[:oauth_secret])

      @current_user = User.find(session[:user_id])
    end
  end
  private
  def consumer
    OAuth::Consumer.new(ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'], :site => 'http://api.twitter.com')
  end
end
