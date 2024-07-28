class ReviewsController < ApplicationController
  def index
    @reviews = current_user.reviews
  end

  def new
    @review = current_user.reviews.find(session[:review_id])
  end

  def show
    @review = Review.find(params[:id])
    @conversations = @review.conversations
  end

  def edit
  end

  def update
    @review = Review.find_by(id: session[:review_id], user_id: current_user.id)
    
    if @review.update(review_params)
      redirect_to review_path(@review), success: "レビューをまとめました"
    else
      flash.now[:danger] = "レビューをまとめられませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:character_count, :title, :summary)
  end
end
