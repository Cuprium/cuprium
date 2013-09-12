class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :loan_product_id, required: true
      t.integer :page, required: true
      t.text :text, required: true

      t.timestamps
    end
  end
end
