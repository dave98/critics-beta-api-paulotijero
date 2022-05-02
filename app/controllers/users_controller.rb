class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: %i[new create]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /profile
  def edit
    @user = current_user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /profile
  def update
    @user = current_user

    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, status: :see_other
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :birth_date, :first_name, :last_name,
                                 :password, :password_confirmation)
  end
end
