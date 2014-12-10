class SessionsController < ApplicationController
  # SESSIONS ARE NOT AN ACTIVE RECORD MODEL

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        # use of ternary operator
        # this is used to see if user checked 'remember me' checkbox
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        # redirect to previous page or defualt page when trying to perform
        # something if not logged in
        redirect_back_or user
      else
        message =  "Account not activated. "
        message += "Check your email for the activation link"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # flash.now is used so when going to homepage the danger
      # message is not there anymore
      # designed for displaying flash on rendered pages
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  # logs out the current user, check session_helper for details
  def destroy
    log_out if logged_in?
    redirect_to root_url, notice: "You have successfully logged out."
  end

end
