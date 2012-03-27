class CreateLedgerEntries < ActiveRecord::Migration
  def change
    create_table :ledger_entries do |t|
      t.decimal :amount, precision: 14, scale: 2, null: false
      t.string :account_id, null: false
      t.string :entry_id, null: false
      t.integer :transaction_id
      t.timestamps
    end
  end
end
