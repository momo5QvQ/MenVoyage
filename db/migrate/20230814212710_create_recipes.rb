class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|

      t.integer :customer_id, null: false
      t.string :name, null: false
      t.text :material, null: false
      t.text :making, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
