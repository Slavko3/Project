class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :count
      t.float :cost

      t.timestamps
    end
  end
end
