class Tag < ApplicationRecord
  has_many :recipe_tags, dependent: :destroy
  has_many :recipes, through: :recipe_tags

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @tag = Tag.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @tag = Tag.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @tag = Tag.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @tag = Tag.where("name LIKE?","%#{word}%")
    else
      @tag = Tag.all
    end
  end

  validates :name, presence: true

end
