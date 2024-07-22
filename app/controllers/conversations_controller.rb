class ConversationsController < ApplicationController
  def query
    user_input = params[:user_input]

    if user_input.present? 
      review = create_review_with_conversation(user_input)
      
      generated_text = get_openai_response(user_input)   
      review.conversations.create(content: generated_text, role: "assistant")
      
      render json:{text: generated_text}
    end
  end

  def create_review_with_conversation(user_input)
    title = user_input.slice(0,15)
    review = Review.create(title: title, summary: "None yet.", user_id: current_user.id)

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
