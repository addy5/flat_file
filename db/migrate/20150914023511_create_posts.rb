class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :artist
      t.integer :year
      t.text :image_url
      t.text :comments
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
