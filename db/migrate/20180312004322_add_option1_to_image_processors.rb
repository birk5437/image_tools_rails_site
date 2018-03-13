class AddOption1ToImageProcessors < ActiveRecord::Migration
  def change
    add_column :image_processors, :option1, :string
  end
end
