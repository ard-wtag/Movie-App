class MoviesController < ApplicationController

  before_action :authenticate_user!, only: [:show, :edit, :update, :delete, :destroy,:new,:create,]

  def index
    @movies=Movie.sorted_by_title
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
    @movie=Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to movie_path(@movie), notice: 'Movie was successfully updated.'
    else
      render :edit
    end
  end 



  def new
    @movie=Movie.new
  end

  def create
    @movie=Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: 'Movie was successfully created.'
    else
      render :new
    end
  end



  def delete
    @movie=Movie.find(params[:id])
  end

  def destroy
    @movie = Movie.find(params[:id])
    if @movie.destroy
      redirect_to movies_path, notice: 'Movie was successfully deleted.'
    else
      redirect_to movies_path, alert: 'Failed to delete movie.'
    end
  end


  private

  def movie_params
    params.require(:movie).permit(:title, :release_date, :director, :synopsis)
  end

end
