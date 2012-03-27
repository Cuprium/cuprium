class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts, id:false do |t|
      t.string :number, null: false
      t.string :owner, null: false
      t.string :type, null: false
      t.decimal :balance, precision: 14, scale: 2, null: false
      t.decimal :debit_limit, precision: 14, scale: 2, null: false

      t.timestamps
    end

    add_index :accounts, :number, unique: true
  end
end
