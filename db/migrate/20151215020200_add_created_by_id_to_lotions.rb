class AddCreatedByIdToLotions < ActiveRecord::Migration
  def change
    add_column :lotions, :created_by_id, :integer
  end
end
