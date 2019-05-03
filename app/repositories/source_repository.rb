# Repository for source object
class SourceRepository
  attr_accessor :object
  def initialize(object)
    @object = object
  end

  # Call from active job
  def active_job
    @object.urls.each do |url|
      web_stat = WebStat.stat_by_url(url)
      Contents::Web.new({
          :title => web_stat[:title],
          :site_name => web_stat[:site_name],
          :content => web_stat[:content],
          :expanded_url => web_stat[:original_url],
          :eyecatch_image_path => web_stat[:eyecatch_image_path],
          :tags => web_stat[:tags],
          :user_id => @object.user_id}).save
    end
  end
end
