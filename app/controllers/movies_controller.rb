# Movie cretion,delete/update actions are handeled from here
class MoviesController < ApplicationController
  before_action :authenticate_user!, only: %i[show edit update delete destroy new create]

  def index
    @movies = Movie.sorted_by_title
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews.includes(:user)

    if @reviews.any?
      n = @reviews.length
      sum = @reviews.sum(&:rating)
      @average_rating = sum.to_f / n
    else
      @average_rating = 0
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      flash[:notice] = 'Movie was successfully updated.'
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = 'Movie was successfully created.'
      redirect_to movies_path
    else
      render :new
    end
  end

  def delete
    @movie = Movie.find(params[:id])
  end

  def destroy
    @movie = Movie.find(params[:id])
    flash[:notice] = if @movie.destroy
                       'Movie was deleted successfully'
                     else
                       'Failed to delete movie.'
                     end
    redirect_to movies_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :release_date, :director, :synopsis, :movie_cover)
  end
end
