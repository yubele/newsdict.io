module Contents
  class Web < ::Content
    # Set attributes by `WebStat` gems
    # @param [Object] Sources
    # @param [Object] web_stat
    # @return [Hash] attributes
    def self.set_attributes_by_web_stat(object, web_stat)
      attrs = {
        :title => "#{web_stat[:url]}#{web_stat[:url]}",
        :site_name => web_stat[:site_name],
        :content => web_stat[:content],
        :expanded_url => web_stat[:url],
        :language_code => web_stat[:language_code],
        :tags => web_stat[:tags],
        :source_id => object.id,
        :user_id => object.user_id
      }
      # image
      unless web_stat[:eyecatch_image_path].nil?
        image = MiniMagick::Image.read(File.read(web_stat[:eyecatch_image_path]))
        image.resize "128x"
        attrs[:image_blob] = BSON::Binary.new(image.to_blob)
      end
      attrs
    end

    # Save a content from job
    # @param [Hash] web_stat
    # @param [Hash] attr
    def self.save_form_job(web_stat, attrs)
      # Check duplicated news
      if content = Contents::Web.find_by(expanded_url: web_stat[:url]) ||
          content = Contents::Web.find_by(title: web_stat[:title])
        content.inc(count_of_shared: 1)
        content.update_attributes(attrs)
      else
        attrs[:count_of_shared] = 1
        Contents::Web.new(attrs).save
      end
    end
  end
end