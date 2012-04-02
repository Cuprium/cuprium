class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies, id:false do |t|
      t.string :code, null:false
      t.string :iso_numberm, null:false
      t.string :name, null:false
      t.integer :decimal_places, null:false

      t.timestamps
    end

    add_column :accounts, :currency_code, :string

    add_index :currencies, :code, unique: true

  end
end
