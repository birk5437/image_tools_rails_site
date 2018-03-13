class CreateHotelsLotions < ActiveRecord::Migration
  def change
    create_table :hotels_lotions, id: false do |t|
      t.integer :hotel_id
      t.integer :lotion_id
    end
  end
end
