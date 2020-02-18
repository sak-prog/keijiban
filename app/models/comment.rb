class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :board
  validates :content , presence: true, length: { maximum: 200 }
end
