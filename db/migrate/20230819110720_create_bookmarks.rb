class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      
      t.references :customer, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
    # bookmarksにおいてcustomer_idとrecipe_idの組み合わせを一意性あるものにする
    add_index  :bookmarks, [:customer_id, :recipe_id], unique: true
  end
end
