class ConvertHotelImages < ActiveRecord::Migration
  def change
    ActiveRecord::Base.connection.execute("update attachinary_files set scope = 'old_logo' where scope = 'logo'")
    hotel_path_prefix = "https://res.cloudinary.com/hotellotiondb/image/upload/"
    hotel_count = Hotel.count
    Hotel.all.each_with_index do |hotel, i|
      begin
        puts "#{i + 1} of #{hotel_count}"
        puts "Hotel ID: #{hotel.id}"
        puts "Hotel Name: #{hotel.name}"
        image_url = hotel_path_prefix + hotel.old_logo.path
        puts image_url
        hotel.logo = open(image_url)
        hotel.save!
      rescue StandardError => e
        puts "############ error! ############"
        puts e.to_s
      end
    end
  end
end
