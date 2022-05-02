class GenresController < ApplicationController
  # GET /genres
  def index
    @genres = Genre.all
  end

  # GET /genres/:id
  def show
    @genre = Genre.find(params[:id])
    authorize @genre
  end

  # GET /genres/new
  def new
    @genre = Genre.new
    authorize @genre
  end

  # GET /genres/:id/edit
  def edit
    @genre = Genre.find(params[:id])
    authorize @genre
  end

  # POST /genres
  def create
    @genre = Genre.new(genre_params)
    authorize @genre

    if @genre.save
      redirect_to @genre
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /genres/:id
  def update
    @genre = Genre.find(params[:id])
    authorize @genre

    if @genre.update(genre_params)
      redirect_to @genre
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /genres/:id
  def destroy
    @genre = Genre.find(params[:id])
    authorize @genre
    @genre.destroy
    redirect_to genres_path, status: :see_other
  end

  private

  # Only allow a list of trusted parameters through.
  def genre_params
    params.require(:genre).permit(:name)
  end
end
