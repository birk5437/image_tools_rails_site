class AddDescriptionToLotions < ActiveRecord::Migration
  def change
    add_column :lotions, :description, :text
  end
end
