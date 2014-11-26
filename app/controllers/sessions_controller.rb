class SessionsController < ApplicationController
  # SESSIONS ARE NOT AN ACTIVE RECORD MODEL

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      # flash.now is used so when going to homepage the danger
      # message is not there anymore
      # designed for displaying flash on rendered pages
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    
  end

end
