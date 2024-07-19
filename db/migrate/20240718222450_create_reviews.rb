class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.string :title, null: false
      t.string :text, null: false
      t.integer :character_count, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
