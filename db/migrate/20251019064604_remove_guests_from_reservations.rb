class RemoveGuestsFromReservations < ActiveRecord::Migration[7.2]
  def change
    remove_column :reservations, :guests, :integer
  end
end
