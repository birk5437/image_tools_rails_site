class ImageProcessor < ActiveRecord::Base

  TYPES = [
    "ImageProcessor::ColorToTransparent",
    "ImageProcessor::ToBlackAndWhite"
  ]

  validates_presence_of :source_image

  # has_attached_file :source_image, :styles => { :tiny => "100x100>", :small => "150x150>", :medium => "400x300>", :large => "800x600>"}
  has_attached_file :source_image, 
    :path =>":rails_root/public/images/assets/source_images/:id/:style.:extension", 
    :url => "/images/assets/source_images/:id/:style.:extension",
    :styles => { :small => "150x150>", :medium => "400x300>"}
  # validates_attachment :source_image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment_content_type :source_image, :content_type => /image/

  # has_attached_file :processed_image, :styles => { :tiny => "100x100>", :small => "150x150>", :medium => "400x300>", :large => "800x600>"}
  has_attached_file :processed_image,
    :path =>":rails_root/public/images/assets/processed_images/:id/:style.:extension",
    :url => "/images/assets/processed_images/:id/:style.:extension",
    :styles => { :small => "150x150", :medium => "400x300>"}
    
  # validates_attachment :processed_image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment_content_type :processed_image, :content_type => /image/

  before_save :process_the_image

  def source_image_chunky_png
    image_data_blob = Paperclip.io_adapters.for(source_image).read
    ChunkyPNG::Image.from_blob(image_data_blob)
  end

  def process_the_image
    begin
      process(source_image.styles[:medium])
      # process(source_image)
    rescue => e
      errors.add(:base, e.message)
      raise ActiveRecord::RecordInvalid, self
    end
  end
end
