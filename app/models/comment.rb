class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :recipe

  validates :comment, presence: true
end
