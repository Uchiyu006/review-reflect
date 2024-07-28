class Conversation < ApplicationRecord
  enum role: { assistant: 0, user: 1 }
  belongs_to :review

  after_create_commit -> { broadcast_created }

  def broadcast_created
    broadcast_append_later_to(
      "review_messages",
      partial: "conversations/conversation",
      locals: { conversation: self, scroll_to: true },
      target: "review_messages",      
    )
  end
end
