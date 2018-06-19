class AddScoreToItem < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :score, :integer, default: 0
  end
end
