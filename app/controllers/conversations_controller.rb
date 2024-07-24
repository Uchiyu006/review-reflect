class ConversationsController < ApplicationController
  def query
    user_input = params[:user_input]

    if user_input.present?
      review = Review.find_or_create_review_with_conversation(user_input, current_user.id, session[:review_id])
      session[:review_id] = review.id
      response_text = AiResponseService.new(review).call

      if response_text
        review.conversations.create(content: response_text, role: "assistant")
      else
        Rails.logger.error("Failed to get response from OpenAI API")
        response_text = "Error: Unable to get response"
      end
      
      render json:{text: response_text}
    end
  end
end
