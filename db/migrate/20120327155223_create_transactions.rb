class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :activity, null:false
      t.integer :from_conversion_id, :to_conversion_id
      t.timestamps
    end
  end
end
