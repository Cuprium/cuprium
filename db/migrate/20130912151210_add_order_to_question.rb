class AddOrderToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :display_order, :integer
  end
end
