class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries, id:false do |t|
      t.integer :direction, null:false
      t.string :name, null:false

      t.timestamps
    end
    add_index :entries, :name, unique: true
  end
end
