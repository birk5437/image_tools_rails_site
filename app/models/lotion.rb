class Lotion < ActiveRecord::Base
  # http://www.sitepoint.com/ratyrate-add-rating-rails-app/
  has_and_belongs_to_many :hotels
  validates_presence_of :name, :image1

  has_attachments :photos, maximum: 10

  belongs_to :created_by, :class_name => "User"

  ratyrate_rateable 'bottle_design', 'overall'

  has_attached_file :image1, :styles => { :tiny => "100x100>", :small => "150x150>", :medium => "400x300>", :large => "800x600>"}
  # validates_attachment :image1, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment_content_type :image1, :content_type => /image/

  has_attached_file :image2, :styles => { :tiny => "100x100>", :small => "150x150>", :medium => "400x300>", :large => "800x600>"}
  # validates_attachment :image2, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment_content_type :image2, :content_type => /image/
end
