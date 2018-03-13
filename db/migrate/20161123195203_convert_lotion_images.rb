class ConvertLotionImages < ActiveRecord::Migration
  def change
    lotion_path_prefix = "https://res.cloudinary.com/hotellotiondb/image/upload/"
    lotion_count = Lotion.count
    Lotion.all.each_with_index do |lotion, i|
      begin
        puts "#{i + 1} of #{lotion_count}"
        puts lotion.name
        puts lotion.id
        puts lotion_path_prefix + lotion.photos.first.path
        if lotion.photos.length == 1
          lotion.image1 = open(lotion_path_prefix + lotion.photos.first.path)
          lotion.save!
        elsif lotion.photos.length == 2
          lotion.image1 = open(lotion_path_prefix + lotion.photos.first.path)
          lotion.image2 = open(lotion_path_prefix + lotion.photos.last.path)
          lotion.save!
        end
      rescue StandardError => e
        puts "########### error! ###########"
        puts e.to_s
      end
    end
  end
end
