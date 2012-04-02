class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies, id:false do |t|
      t.string :code
      t.string :iso_number
      t.string :name
      t.integer :decimal_places

      t.timestamps
    end

    add_column :accounts, :currency_code, :string

    add_index :currencies, :code, unique: true

  end
end
