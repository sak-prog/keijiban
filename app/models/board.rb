class Board < ApplicationRecord
  validates :title, length: { maximum: 100 }
end
