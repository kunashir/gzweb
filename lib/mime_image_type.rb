module Mime

  class Type

    def self.lookup_by_image_content(image_bytes)
      png = Regexp.new("\x89PNG".force_encoding("binary"))
      jpg = Regexp.new("\xff\xd8\xff\xe0\x00\x10JFIF".force_encoding("binary"))
      jpg2 = Regexp.new("\xff\xd8\xff\xe1(.*){2}Exif".force_encoding("binary"))
      case image_bytes[0..10]
        when /^GIF8/
          Mime::Type.new('image/gif')
        when /^#{png}/
          Mime::Type.new('image/png')
        when /^#{jpg}/
          Mime::Type.new('image/jpeg')
        when /^#{jpg2}/
          Mime::Type.new('image/jpeg')
        when /^BM/
          Mime::Type.new('image/bmp')
        else
          nil
      end  
    end

  end
end