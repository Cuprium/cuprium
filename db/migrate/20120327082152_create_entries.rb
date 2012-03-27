class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries, id:false do |t|
      t.integer :direction
      t.string :name

      t.timestamps
    end
    add_index :entries, :name, unique: true
  end
end
