class AiResponseService
  def initialize(review)
    Rails.logger.error("initialize")
    @review = review
  end

  def call
    Rails.logger.error("call")
    generate_ai_response
  end

  private

  def generate_ai_response
    Rails.logger.error("generate_ai_response")
    messages = @review.conversations.order(:created_at).map do |conversation|
      {
        role: conversation.role,
        content: conversation.content
      }
    end

    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "ユーザーのメッセージに対して深掘りする質問をしてください" },
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
end
