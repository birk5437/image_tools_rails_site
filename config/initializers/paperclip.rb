class Paperclip::Attachment
  def as_chunky_png

    image_data_blob = Paperclip.io_adapters.for(self).read
    if self.content_type.to_s.split("/").last.downcase != "png"
      res = MiniMagick::Image.read(image_data_blob)
      res.format("png")
      ChunkyPNG::Image.from_blob(res.tempfile.open.read)
    else
      ChunkyPNG::Image.from_blob(image_data_blob)
    end
  end
end

class Paperclip::Style
  def as_chunky_png
    image_data_blob = Paperclip.io_adapters.for(self).read
    if attachment.content_type.to_s.split("/").last.downcase != "png"
      res = MiniMagick::Image.read(image_data_blob)
      res.format("png")
      ChunkyPNG::Image.from_blob(res.tempfile.open.read)
    else
      ChunkyPNG::Image.from_blob(image_data_blob)
    end
    # image_data_blob = Paperclip.io_adapters.for(self).read
    # ChunkyPNG::Image.from_blob(image_data_blob)
  end
end
