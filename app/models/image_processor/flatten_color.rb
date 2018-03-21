class ImageProcessor::FlattenColor < ImageProcessor
  validates :option1, presence: true
  before_validation :set_default_option1

  def set_default_option1
    Rails::logger.warn("BURKE - type #{type}")
    Rails::logger.warn("BURKE - type was #{type_was}")
    Rails::logger.warn("BURKE - type changed? #{type_changed?}")
    self.option1 = "3" if option1.blank? || type_changed?
  end
  def process(paperclip_attachment=source_image, number_of_colors="3", option2=nil)
    number_of_colors = number_of_colors.presence || "3"
    png = paperclip_attachment.as_chunky_png
    dim = png.dimension
    # puts dim.width
    # puts dim.height

    data = []

    for y in 0..dim.height - 1 do
      for x in 0..dim.width - 1 do  
        color_value = png[x,y]

        if ChunkyPNG::Color.a(color_value) == 0
          Rails::logger.warn("NEXT")
          next
        end

        Rails::logger.warn("loading data")
        data << [ChunkyPNG::Color.r(color_value), ChunkyPNG::Color.g(color_value), ChunkyPNG::Color.b(color_value), ChunkyPNG::Color.a(color_value)]
        # data << png[x,y]
      end
    end

    # png[1,1] = ChunkyPNG::Color.rgba(10, 20, 30, 128)
    # png[2,1] = ChunkyPNG::Color('black @ 0.5')
    # png.save('filename.png', :interlace => true)

    # # Compose images using alpha blending.
    # avatar = ChunkyPNG::Image.from_file('avatar.png')
    # badge  = ChunkyPNG::Image.from_file('no_ie_badge.png')

    Rails::logger.warn("running kmeans")
    kmeans = KMeansClusterer.run number_of_colors.to_i, data, runs: 1, log: true


    for y in 0..dim.height - 1 do
      for x in 0..dim.width - 1 do  
        color_value = png[x,y]

        if ChunkyPNG::Color.a(color_value) == 0
          Rails::logger.warn("NEXT")
          next
        end
        # data << [ChunkyPNG::Color.r(color_value), ChunkyPNG::Color.g(color_value), ChunkyPNG::Color.b(color_value)]
        # data << png[x,y]
        Rails::logger.warn("predicting")
        predicted = kmeans.predict [[ChunkyPNG::Color.r(color_value), ChunkyPNG::Color.g(color_value), ChunkyPNG::Color.b(color_value), ChunkyPNG::Color.a(color_value)]]
        centroid_data = Array(kmeans.clusters[predicted[0]].centroid.data).map{ |d| d.round(0).to_i }
        png[x,y] = ChunkyPNG::Color.rgba(centroid_data[0], centroid_data[1],centroid_data[2], centroid_data[3])
      end
    end
    Rails::logger.warn("saving flatten color image")
    self.processed_image = png.as_fake_file
    # png.save("#{ARGV[0].gsub('.png', '')}_processed.png", {fast_rgba: true, interlace: true})#, :interlace => true)
  end
end
