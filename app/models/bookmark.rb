class Bookmark < ApplicationRecord
  belongs_to :customer
  belongs_to :recipe

  #重複したお気に入り登録ができないようにバリデーション
  #ユニーク制約にscopeをつけることで一つの投稿に同じユーザーが重複してお気に入りできないようにする
  validates :customer_id, uniqueness: { scope: :recipe_id }
end
