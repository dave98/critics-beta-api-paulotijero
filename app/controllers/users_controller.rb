class UsersController < ApplicationController
  # GET /profile
  def show
    @user = current_user
  end
end
