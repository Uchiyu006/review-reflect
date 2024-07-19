class ChangeColumnTypeFromReviews < ActiveRecord::Migration[7.1]
  def change
    change_column :reviews, :summary, :text
  end
end
