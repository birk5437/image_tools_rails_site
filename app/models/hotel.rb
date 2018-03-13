class Hotel < ActiveRecord::Base
  has_and_belongs_to_many :lotions
  validates_presence_of :name

  has_attachment :old_logo

  has_attached_file :logo, :styles => { :tiny => "100x100>", :small => "150x150>", :medium => "400x300>", :large => "800x600>"}
  validates :logo, presence: true
  validates_attachment :logo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  belongs_to :created_by, class_name: "User"
end
