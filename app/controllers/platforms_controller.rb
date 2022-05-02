class PlatformsController < ApplicationController
  # GET /platforms
  def index
    @platforms = Platform.all
  end

  # GET /platforms/:id
  def show
    @platform = Platform.find(params[:id])
    authorize @platform
  end

  # GET /platforms/new
  def new
    @platform = Platform.new
    authorize @platform
  end

  # GET /platforms/:id/edit
  def edit
    @platform = Platform.find(params[:id])
    authorize @platform
  end

  # POST /platforms
  def create
    @platform = Platform.new(platform_params)
    authorize @platform

    if @platform.save
      redirect_to @platform
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /platforms/:id
  def update
    @platform = Platform.find(params[:id])
    authorize @platform

    if @platform.update(platform_params)
      redirect_to @platform
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /platforms/:id
  def destroy
    @platform = Platform.find(params[:id])
    authorize @platform

    @platform.destroy
    redirect_to platforms_url, status: :see_other
  end

  private

  # Only allow a list of trusted parameters through.
  def platform_params
    params.require(:platform).permit(:name, :category)
  end
end
