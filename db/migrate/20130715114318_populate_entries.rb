class PopulateEntries < ActiveRecord::Migration
  def up
    [
      {
      direction: 1,
      name: "payment" },
      {
      direction: -1,
      name: "withdrawal"},
      {
      direction: 1,
      name: "transfer_in"},
      {
      direction: -1,
      name: "transfer_out"
      }
    ].each do |entry_data|
      Entry.create(entry_data) unless Entry.find_by_name(entry_data[:name])
    end
  end

  def down
  end
end
