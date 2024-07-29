class AiResponseService
  def initialize(review, prompt)
    @review = review
    @prompt = prompt
  end

  def call
    generate_ai_response
  end

  private

  def generate_ai_response
    messages = get_messages(@review)

    Rails.logger.error("messages: #{messages}")

    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: @prompt },
        ] + messages,
        temperature: 0.7,
        max_tokens: 1000,
      }
    )
    response.dig("choices", 0, "message", "content")

  rescue => e
    Rails.logger.error("OpenAI API request failed: #{e.message}")
    "Error: Unable to get response"
  end

  def get_messages(review)
    review.conversations.order(:created_at).map do |conversation|
      {
        role: conversation.role,
        content: conversation.content
      }
    end
  end
end
