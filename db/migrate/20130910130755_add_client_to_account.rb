class AddClientToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :client_id, :integer
  end
end
