class Conversation < ApplicationRecord
  enum role: { assistant: 0, user: 1 }
  belongs_to :review
end
