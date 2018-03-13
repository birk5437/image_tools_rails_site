class AddPaperclipAttachmentToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :logo_file_name, :string
    add_column :hotels, :logo_content_type, :string
    add_column :hotels, :logo_file_size, :integer
    add_column :hotels, :logo_updated_at, :datetime
  end
end
