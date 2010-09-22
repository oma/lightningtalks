class OauthController < ApplicationController
  def new
    request_token = consumer.get_request_token(:oauth_callback => url_for(:action => :callback))

    session[:oauth_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end

  # params[:oauth_token] params[:oauth_verifier]
  def callback
    request_token = OAuth::RequestToken.new(consumer, 
                                            params[:oauth_token],
                                            session[:oauth_secret])

    # Swap the authorized request token for an access token                                        
    access_token = request_token.get_access_token(
                      {:oauth_verifier => params[:oauth_verifier]})
    # Save the token and secret to the session
    # We use these to recreate the access token
    session[:oauth_token] = access_token.token
    session[:oauth_secret] = access_token.secret

    u = User.find_or_create_by_twitter_id access_token.params['user_id']
    session[:user_id] = u.id
    redirect_to "/"
  end

end
