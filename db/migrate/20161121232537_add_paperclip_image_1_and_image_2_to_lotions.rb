class AddPaperclipImage1AndImage2ToLotions < ActiveRecord::Migration
  def change
    add_column :lotions, :image1_file_name, :string
    add_column :lotions, :image1_content_type, :string
    add_column :lotions, :image1_file_size, :integer
    add_column :lotions, :image1_updated_at, :datetime
    add_column :lotions, :image2_file_name, :string
    add_column :lotions, :image2_content_type, :string
    add_column :lotions, :image2_file_size, :integer
    add_column :lotions, :image2_updated_at, :datetime
  end
end
