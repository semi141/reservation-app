class AddNumberOfPeopleToReservations < ActiveRecord::Migration[7.2]
  def change
    add_column :reservations, :number_of_people, :integer
  end
end
