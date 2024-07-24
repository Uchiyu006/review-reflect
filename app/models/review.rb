class Review < ApplicationRecord
  belongs_to :user
  has_many :conversations, dependent: :destroy

  def self.find_or_create_review_with_conversation(user_input, user_id, session)
    review = find_or_create_by(id: session[:review_id], user_id: user_id) do |new_review|
      new_review.title = user_input.slice(0, 15)
      new_review.summary = "None yet."
      new_review.user_id = user_id
    end

    if review.persisted?
      review.conversations.create(content: user_input, role: "user")
    else
      Rails.logger.error("Failed to save review: #{review.errors.full_messages.join(', ')}")
    end

    review
  end
end
