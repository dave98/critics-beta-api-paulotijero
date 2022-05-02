class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  # GET /login
  def new; end

  # POST /sessions => formulario body { email: xxxx, password: xxxx }
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      log_in(user)
      redirect_to root_path
    else
      flash.now[:message] = "Invalid credentials"
      render "new", status: :unprocessable_entity
    end
  end

  # DELETE /sessions
  def destroy
    logout
    redirect_to root_path, status: :see_other
  end
end
