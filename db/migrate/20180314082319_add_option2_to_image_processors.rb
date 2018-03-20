class AddOption2ToImageProcessors < ActiveRecord::Migration
  def change
    add_column :image_processors, :option2, :string
  end
end
