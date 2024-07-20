class CreateConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      t.integer :role, null: false
      t.text :content, null: false
      t.references :review, foreign_key: true
      t.timestamps
    end
  end
end
