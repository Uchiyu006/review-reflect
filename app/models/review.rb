class Review < ApplicationRecord
  belongs_to :user
  has_many :conversations, dependent: :destroy

  def self.find_or_create_review(user_input, user_id, review_id)
    if review_id
      review = find_by(id: review_id, user_id: user_id)
    end

    unless review
      title = user_input.slice(0,15)
      review = create(title: title, summary: "None yet.", user_id: user_id)
    end

    review
  end
end
