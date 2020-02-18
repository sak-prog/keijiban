class Board < ApplicationRecord
  acts_as_taggable
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :title, length: { maximum: 100 }
end
