class AddCreatedByIdToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :created_by_id, :integer
  end
end
