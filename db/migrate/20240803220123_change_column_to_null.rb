class ChangeColumnToNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :reviews, :summary, true
  end
end
