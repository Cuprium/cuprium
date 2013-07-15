class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :title_id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :address1, null: false
      t.string :address2
      t.string :address3
      t.string :town, null: false
      t.string :postcode, null: false
      t.string :email

      t.timestamps
    end
  end
end
