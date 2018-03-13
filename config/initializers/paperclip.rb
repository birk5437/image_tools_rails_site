class Paperclip::Attachment
  def as_chunky_png
    image_data_blob = Paperclip.io_adapters.for(self).read
    ChunkyPNG::Image.from_blob(image_data_blob)
  end
end

class Paperclip::Style
  def as_chunky_png
    image_data_blob = Paperclip.io_adapters.for(self).read
    ChunkyPNG::Image.from_blob(image_data_blob)
  end
end
