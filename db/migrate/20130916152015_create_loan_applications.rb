class CreateLoanApplications < ActiveRecord::Migration
  def change
    create_table :loan_applications do |t|
      t.string :state
      t.integer :client_id
      t.integer :loan_product_id
      t.text :client_details
      t.text :responses

      t.timestamps
    end
  end
end
