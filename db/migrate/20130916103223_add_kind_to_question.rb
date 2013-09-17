class AddKindToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :kind, :string, default: 'yesno', required: true
    add_column :questions, :list_values, :string
  end
end
