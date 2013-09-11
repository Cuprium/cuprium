class AddColumnsToClient < ActiveRecord::Migration
  def change
    add_column :clients, :date_of_birth, :date
    add_column :clients, :phone, :string
    add_column :clients, :alt_phone, :string
  end
end
