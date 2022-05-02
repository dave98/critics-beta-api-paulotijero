class CriticsController < ApplicationController
  # GET /critics
  def index
    # @critics = Critic.all
    @critics = policy_scope(Critic)
  end

  # GET /critics/:id
  def show
    @critic = Critic.find(params[:id])
    authorize @critic
  end

  # GET /critics/new || /critics/new?game_id=:id || /critics/new?company_id=:id
  # GET /games/:game_id/critics/new
  # GET /company/:company_id/critics/new
  def new
    criticable = Game.find(params[:game_id]) if params[:game_id]
    criticable = Company.find(params[:company_id]) if params[:company_id]
    if criticable
      @critic = criticable.critics.new
      authorize @critic
    else
      render "criticable"
    end
  end

  # GET /critics/:id/edit
  def edit
    @critic = Critic.find(params[:id])
    authorize @critic
  end

  # POST /critics
  # POST /games/:game_id/critics
  # POST /company/:company_id/critics
  def create
    criticable = Game.find(params[:game_id]) if params[:game_id]
    criticable = Company.find(params[:company_id]) if params[:company_id]

    @critic = criticable.critics.new(permitted_attributes(Critic))
    @critic.user = current_user
    authorize @critic

    if @critic.save
      redirect_to @critic
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /critics/:id
  def update
    @critic = Critic.find(params[:id])
    authorize @critic

    if @critic.update(permitted_attributes(@critic))
      redirect_to @critic
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /critics/:id
  def destroy
    @critic = Critic.find(params[:id])
    authorize @critic

    @critic.destroy
    redirect_to critics_path, status: :see_other
  end

  private

  # Only allow a list of trusted parameters through.
  def critic_params
    params.require(:critic).permit(:title, :body, :approved)
  end
end
