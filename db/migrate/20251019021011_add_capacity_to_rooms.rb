class AddCapacityToRooms < ActiveRecord::Migration[7.2]
  def change
    add_column :rooms, :capacity, :integer
  end
end
