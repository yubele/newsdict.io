module ContentConcern
  extend ActiveSupport::Concern
  class_methods do
    # Set attributes by `WebStat` gems
    # @param [Source] object
    # @param [Object] web_stat
    # @return [Hash] attributes
    def set_attributes_by_web_stat(object, web_stat)
      attrs = {
        :title => web_stat[:title],
        :site_name => web_stat[:site_name],
        :content => web_stat[:content],
        :expanded_url => web_stat[:url],
        :http_status => web_stat[:http_status],
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
    # @param [Hash] attrs
    def save_form_job(attrs)
      content = Contents::Web.new(attrs)
      # Check duplicated news
      if content = (content.unique? || content)
        content.update_attributes(attrs)
        content.inc(count_of_shared: 1)
      else
        content.count_of_shared = 1
        content.save
      end
    end
    # Get the records
    # @param order default :desc
    # @param category_id default: nil
    def contents(order: :desc, category_id: nil, name: nil)
      if name
        collection = self.in(source_id: Source.find_by(name: name))
      elsif category_id
        collection = self.in(source_id: Source.where(category_id: category_id).map {|u| u.id })
      else
        collection = self.in(source_id: Source.all.map {|u| u.id })
      end
      if ::Filters::Content.exists?
        collection.not(expanded_url: /(#{::Filters::Content.all.map {|c| c.exclude_url }.join('|')})/)
      else
        collection.all
      end
    end
    # Sort the content by sort_type
    # @param [String] sort_type
    def sortable(sort_type)
      if sort_type && Content::SORT_TYPE.key?(sort_type.to_sym)
        self.order_by((Content::SORT_TYPE[sort_type.to_sym]))
      else
        self.order_by((Content::SORT_TYPE[:newest]))
      end
    end
  end
end