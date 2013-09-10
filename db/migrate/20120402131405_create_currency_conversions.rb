class CreateCurrencyConversions < ActiveRecord::Migration
  def change
    create_table :currency_conversions do |t|
      t.string :currency_code, null:false
      t.date :valid_from, null:false
      t.decimal :factor, precision: 14, scale: 4, null: false
      t.timestamps
    end
    add_index :currency_conversions, [:currency_code,:valid_from], unique: true

  end
end
