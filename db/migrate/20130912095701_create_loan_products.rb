class CreateLoanProducts < ActiveRecord::Migration
  def change
    create_table :loan_products do |t|
      t.string :name, required: true

      t.timestamps
    end
  end
end
