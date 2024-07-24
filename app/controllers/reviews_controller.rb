class ReviewsController < ApplicationController
  def index
    @reviews = current_user.reviews
  end

  def new
    session[:review_id] = nil
    @review = Review.new
  end

  def create
    @review = Review.find_by(id: session[:review_id], user_id: current_user.id)
    
    if @review.update(review_params)
      redirect_to review_path(@review), success: "レビューをまとめました"
    else
      flash.now[:danger] = "レビューをまとめられませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  def edit
    @review = current_user.reviews.find(params[:id])
    @conversations = @review.conversations.order(created_at: :asc)    
  end

  def updated

  end

  private

  def review_params
    params.require(:review).permit(:character_count, :title, :summary)
  end
end
