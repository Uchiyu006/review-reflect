class ConversationsController < ApplicationController
  def new
    @conversation = Conversation.new
    @review = Review.new
    session[:review_id] = nil
  end

  def create
    user_input = conversation_params[:content]

    @review = Review.find_or_create_review(user_input, current_user.id, session[:review_id])
    session[:review_id] = @review.id

    @user_conversation = @review.conversations.create(content: user_input, role: "user") 
    response_text = AiResponseService.new(@review).call
    @assistant_conversation = @review.conversations.create(content: response_text, role: "assistant") 

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:content)
  end
end
