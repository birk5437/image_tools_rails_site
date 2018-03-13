class CreateImageProcessors < ActiveRecord::Migration
  def change
    create_table :image_processors do |t|
      t.string :type
      t.timestamps
    end
    add_column :image_processors, :source_image_file_name, :string
    add_column :image_processors, :source_image_content_type, :string
    add_column :image_processors, :source_image_file_size, :integer
    add_column :image_processors, :source_image_updated_at, :datetime
    add_column :image_processors, :processed_image_file_name, :string
    add_column :image_processors, :processed_image_content_type, :string
    add_column :image_processors, :processed_image_file_size, :integer
    add_column :image_processors, :processed_image_updated_at, :datetime
  end
end
