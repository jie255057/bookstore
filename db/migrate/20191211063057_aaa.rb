class Aaa < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :category_id, :integer, foreign_key: true
  end
end
