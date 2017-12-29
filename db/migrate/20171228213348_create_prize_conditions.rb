class CreatePrizeConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :prize_conditions do |t|
      t.string :name
      t.references :prize
      t.json :rules
      t.boolean :overlapped
      t.timestamps
    end
  end
end
