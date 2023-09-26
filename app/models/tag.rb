class Tag < ApplicationRecord
  has_many :recipe_tags, dependent: :destroy
  has_many :recipes, through: :recipe_tags

  validates :name, presence: true
  before_save :strip_whitespace

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

  private

  def strip_whitespace
    self.name.strip!  # tag_nameフィールドの前後の空白を削除
  end

end
