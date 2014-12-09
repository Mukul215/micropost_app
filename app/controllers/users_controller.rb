class UsersController < ApplicationController
  # requires users to be logged in to edit these features
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    # we are using this instead of User.all so that we can
    # paginate all the users rather than have them all on one page
    @users = User.paginate(page: params[:page])
  end

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
      # logs user in
      log_in @user
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    # used as a more secure way of justifying which params users can fill in
    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation)
    end

    #
    # Before filters below
    #

    # confirms a logged in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    # confirms correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end