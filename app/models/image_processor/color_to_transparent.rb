class ImageProcessor::ColorToTransparent < ImageProcessor
  def process(paperclip_attachment=source_image)
    # file_name = source_image.path
    # directory = ARGV[0].gsub(file_name, "")
    # new_file_name = "#{file_name.gsub('.png', '')}_transparent.png"

    white_cutoff = 240

    png = paperclip_attachment.as_chunky_png
    # png = ChunkyPNG::Image.from_blob(ARGF)
    dim = png.dimension
    # puts dim.width
    # puts dim.height

    for y in 0..dim.height - 1 do
      for x in 0..dim.width - 1 do  
        color_value = png[x,y]
        black_distance = ChunkyPNG::Color.euclidean_distance_rgba(color_value, ChunkyPNG::Color::PREDEFINED_COLORS[:black])
        white_distance = ChunkyPNG::Color.euclidean_distance_rgba(color_value, ChunkyPNG::Color::PREDEFINED_COLORS[:white])

        if png[x,y] >= ChunkyPNG::Color.rgb(white_cutoff, white_cutoff,white_cutoff)
          # png[x,y] = ChunkyPNG::Color::PREDEFINED_COLORS[:cyan]
          # png[x,y] = ChunkyPNG::Color.rgba(231, 212,129, 255)
          png[x,y] = ChunkyPNG::Color.rgba(0, 0,0,0)
        else
          
        end
        # puts png[x,y]
        # puts "#{black_distance} | #{white_distance}"
      end
      # puts y
    end

    self.processed_image = png.as_fake_file

  end
end
