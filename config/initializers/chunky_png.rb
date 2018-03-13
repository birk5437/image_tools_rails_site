class ChunkyPNG::Image
  def as_fake_file(filename="#{SecureRandom.hex}.png")
    thing = StringIO.new(to_blob) #mimic a real upload file
    thing.class.class_eval { attr_accessor :original_filename, :content_type } #add attr's that paperclip needs
    thing.original_filename = filename #assign filename in way that paperclip likes
    thing.content_type = "image/png" # you could set this manually aswell if needed e.g 'application/pdf'
    thing
  end
end
