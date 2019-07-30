# Repository for source object
class SourceRepository
  attr_accessor :object

  # initialize
  # @param [Source]
  def initialize(object)
    @object = object
  end

  # Call from active job
  def active_job
    @object.urls.each do |url|
      web_stat = WebStat.stat_by_url(url)
      attrs = {
          :title => web_stat[:title],
          :site_name => web_stat[:site_name],
          :content => web_stat[:content],
          :expanded_url => web_stat[:url],
          :tags => web_stat[:tags],
          :source_id => @object.id,
          :user_id => @object.user_id
      }
      # image
      unless web_stat[:eyecatch_image_path].nil?
        image = MiniMagick::Image.read(File.read(web_stat[:eyecatch_image_path]))
        image.resize "128x"
        attrs[:image_blob] = BSON::Binary.new(image.to_blob)
      end
      if content = Contents::Web.where(expanded_url: web_stat[:url]).exists?
        content.update_attributes(attrs)
      else
        Contents::Web.new(attrs).save
      end
    end
  end
end
