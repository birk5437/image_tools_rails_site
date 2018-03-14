class ImageProcessor::ToBlackAndWhite < ImageProcessor
  def process(paperclip_attachment_or_style=source_image, option1=nil)
    png = paperclip_attachment_or_style.as_chunky_png
    dim = png.dimension
    # puts dim.width
    # puts dim.height

    for y in 0..dim.height - 1 do
      for x in 0..dim.width - 1 do  
        color_value = png[x,y]
        black_distance = ChunkyPNG::Color.euclidean_distance_rgba(color_value, ChunkyPNG::Color::PREDEFINED_COLORS[:black])
        white_distance = ChunkyPNG::Color.euclidean_distance_rgba(color_value, ChunkyPNG::Color::PREDEFINED_COLORS[:white])

        next if ChunkyPNG::Color.a(color_value) < 10
        if black_distance < white_distance
          # png[x,y] = ChunkyPNG::Color::PREDEFINED_COLORS[:cyan]
          png[x,y] = ChunkyPNG::Color.rgba(0,0,0,255)
        else
          png[x,y] = ChunkyPNG::Color.rgba(255, 255,255, 255)
        end
        # puts png[x,y]
        # puts "#{black_distance} | #{white_distance}"
      end
      puts y
    end

    self.processed_image = png.as_fake_file
  end
end
