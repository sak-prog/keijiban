class Board < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, length: { maximum: 100 }
end
