class UsersController < ApplicationController

  def show
    # this is used to find users by their ID
    @user = User.find(params[:id])
  end

  def new
    # used to create new user
    @user = User.new
  end
end
