class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :activity

      t.timestamps
    end
  end
end
