class RecipeTag < ApplicationRecord
  #タグの中間テーブルモデル
  belongs_to :recipe
  belongs_to :tag

  # validateをいれることで重複を防ぐ
  validates :recipe_id, presence: true
  validates :tag_id, presence: true
end
