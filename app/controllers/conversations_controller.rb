class ConversationsController < ApplicationController
  def query
    user_input = params[:user_input]

    if user_input.present? 
      review = find_or_create_review_with_conversation(user_input)
      
      generated_text = get_openai_response(user_input)   
      review.conversations.create(content: generated_text, role: "assistant")
      
      render json:{text: generated_text}
    end
  end

  def find_or_create_review_with_conversation(user_input)
    if session[:review_id]
      review = Review.find_by(id: session[:review_id], user_id: current_user.id)
    end

    unless review
      title = user_input.slice(0,15)
      review = Review.create(title: title, summary: "None yet.", user_id: current_user.id)
      session[:review_id] = review.id if review.persisted?
    end

    if review.persisted?
      review.conversations.create(content: user_input, role: "user")
    else
      Rails.logger.error("Failed to save review: #{review.errors.full_messages.join(", ")}")
    end

    review
  end

  def get_openai_response(user_input)
    client = OpenAI::Client.new

    response = client.chat(
      parameters:{
        model: "gpt-3.5-turbo",
        messages:[
          { role: "system", content: "ユーザーのメッセージに対して深掘りする質問をしてください"},
          { role: "user", content: user_input}
        ],
        temperature: 0.7
      }
    )

    response.dig("choices", 0, "message", "content")

  rescue => e
    Rails.logger.error("OpenAI API request failed: #{e.message}")
    "Error: Unable to get response"
  end
end
