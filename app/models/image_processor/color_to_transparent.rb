class ImageProcessor::ColorToTransparent < ImageProcessor
  before_validation :set_default_option1, :set_default_option2

  def set_default_option1
    self.option1 = "#FFFFFF" if option1.blank? || type_changed?
  end

  def set_default_option2
    self.option2 = "50" if option2.blank? || type_changed?
  end

  def process(paperclip_attachment=source_image, target_color="#FFFFFF", eucledian_distance_range="0")
    # file_name = source_image.path
    # directory = ARGV[0].gsub(file_name, "")
    # new_file_name = "#{file_name.gsub('.png', '')}_transparent.png"

    white_cutoff = 240

    png = paperclip_attachment.as_chunky_png
    # png = ChunkyPNG::Image.from_blob(ARGF)
    dim = png.dimension
    # puts dim.width
    # puts dim.height

    target_color_as_chunky = ChunkyPNG::Color.from_hex(target_color)

    for y in 0..dim.height - 1 do
      total_px = dim.height
      progress = y
      Rails::logger.warn("BURKE - #{progress} of #{total_px} ( #{(progress.to_f / total_px.to_f).round(2) * 100} pct)")
      for x in 0..dim.width - 1 do  
        # color_value = png[x,y]
        pixel_color = png[x,y]
        distance_from_target_color = ChunkyPNG::Color.euclidean_distance_rgba(pixel_color, target_color_as_chunky)
        # Rails::logger.warn("BURKE - RANGE INPUT == #{eucledian_distance_range.to_i}")
        # Rails::logger.warn("BURKE - ACTUAL DISTANCE == #{distance_from_target_color}")
        if distance_from_target_color <= eucledian_distance_range.to_i
          # png[x,y] = ChunkyPNG::Color::PREDEFINED_COLORS[:cyan]
          # png[x,y] = ChunkyPNG::Color.rgba(231, 212,129, 255)
          png[x,y] = ChunkyPNG::Color.rgba(0, 0,0,0)
        end
        # puts png[x,y]
        # puts "#{black_distance} | #{white_distance}"
      end
      # puts y
    end

    self.processed_image = png.as_fake_file

  end
end
