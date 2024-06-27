class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
  end

  def show
    #@review = Review.find(params[:id])
  end

  def new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.new(review_params)
    @review.user = current_user  # or however you get the current user

    if @review.save
      redirect_to @movie, notice: 'Review was successfully created.'
    else
      @reviews = @movie.reviews.includes(:user)
      @average_rating = @reviews.average(:rating).to_f.round(2)
      render 'movies/show' 
    end
  end

  def edit
    # the @review variable is already set using the set_review method 
  end

  def update
    if @review.update(review_params)
      redirect_to @review, notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def delete
    @review=Review.find(params[:id])
  end

  def destroy
    begin
      @review = Review.find(params[:id])
  
      if (current_user && @review.user_id == current_user.id) || current_admin
        @review.destroy
        redirect_to movie_path(@review.movie), notice: 'Review was successfully deleted.'
      else
        redirect_to movie_path(@review.movie), alert: 'You do not have permission to delete this review.'
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to movies_path, alert: 'Review not found.'
    end
  end
  

  private

  def review_params
    params.require(:review).permit(:rating, :review)
  end 

  def set_review
    @review = Review.find(params[:id])
  end


end
