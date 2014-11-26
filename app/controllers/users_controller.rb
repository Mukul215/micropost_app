class UsersController < ApplicationController

  def show
    # this is used to find users by their ID
    @user = User.find(params[:id])
  end

  def new
    # used to create new user
    @user = User.new
  end

  def create
    # this method is used in conjunction with the form to create new users
    @user = User.new(user_params)
    if @user.save
      # greets users, disappears after visiting another page or reloading page
      flash[:success] = "Welcome To The Sample App!"
      # after successful completion of signup, user will be redirected
      # to own users page
      # we could have used 'redirect_to user_url(@user)' but not needed
      # rails automatically knows what we are asking
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    # used as a more secure way of justifying which params users can fill in
    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation)
    end
end