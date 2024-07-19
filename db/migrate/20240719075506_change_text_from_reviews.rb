class ChangeTextFromReviews < ActiveRecord::Migration[7.1]
  def change
    rename_column :reviews, :text, :summary
  end
end
