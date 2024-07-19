class RemoveNullConstraintFromReviews < ActiveRecord::Migration[7.1]
  def change
    change_column_null :reviews, :character_count, true
  end
end
