class ReviewsController < ApplicationController
  before_action :set_review, only: [:update]

  def index
    @reviews = current_user.reviews.order(created_at: :desc)
  end

  def new
    @conversation = Conversation.new
    @review = Review.new
    session[:review_id] = nil
  end

  def show
    @review = Review.find(params[:id])
    @conversations = @review.conversations
  end

  def edit
    @review = current_user.reviews.find(session[:review_id])
    @conversations = @review.conversations
  end

  def update
    if params[:summarize]
      summarize_review
    else
      save_review
    end
  end

  def summarize_review
    @conversations = @review.conversations
    character_count = review_params[:character_count]
    prompt = "今までのやりとりからレビューを#{character_count}文字以内でまとめてください。"
    response_text = AiResponseService.new(@review, prompt).call

    if @review.update(
      character_count: review_params[:character_count],
      title: review_params[:title],
      summary: response_text)
      render :edit
    else
      flash.now[:danger] = "Error: Unable to get response"
      render :edit, status: :unprocessable_entity
    end
  end

  def save_review
    if @review.update(review_params)
      Rails.logger.debug("Review ID after update: #{@review.id}")
      redirect_to review_path(@review), success: "レビューをまとめました"
    else
      Rails.logger.debug("Review update failed")
      flash.now[:danger] = "レビューをまとめられませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:character_count, :title, :summary)
  end
end
