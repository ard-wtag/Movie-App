# new comment create and update or delete actions are handeled from here
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def show
    @review = Review.find(params[:review_id])
    @movie = @review.movie
    @comments = @review.comments.includes(:user)
  end

  def new; end

  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.new(comment_params)
    @comment.user = current_user # or however you get the current user

    if @comment.save
      redirect_to review_path(@review.id), notice: 'Comment was successfully created.'
    else
      @movie = @review.movie
      @comments = @review.comments.includes(:user)
      render :show
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @review = @comment.review
    redirect_to review_path(@review) unless @comment.user_id == current_user.id
  end

  def update
    @comment = Comment.find(params[:id])
    @review = @comment.review
    if @comment.update(comment_params)
      redirect_to review_path(@review), notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def delete; end

  def destroy
    @comment = Comment.find(params[:id])
    @review = @comment.review

    if (current_user.present? && @comment.user_id == current_user.id) || current_admin.present?
      @comment.destroy
      redirect_to review_path(@review), notice: 'Comment was successfully deleted.'
    else
      redirect_to review_path(@review), alert: 'You do not have permission to delete this comment.'
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to reviews_path, alert: 'Comment not found.'
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
