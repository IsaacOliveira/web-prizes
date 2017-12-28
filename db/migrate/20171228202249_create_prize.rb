class CreatePrize < ActiveRecord::Migration[5.1]
  def change
    create_table :prizes do |t|
      t.string :name
      t.integer :quantity

      t.timestamp
    end
  end
end
