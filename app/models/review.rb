class Review < ApplicationRecord
  belongs_to :user
  has_many :conversations, dependent: :destroy
end
