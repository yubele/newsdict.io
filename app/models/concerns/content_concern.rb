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
    # @param category default: nil
    def contents(order: :desc, category: nil, name: nil)
      if name
        self.in(source_id: Sources::TwitterAccount.find_by(name: name))
      elsif category
        self.in(source_id: Sources::TwitterAccount.where(category: category).map {|u| u.id })
      else
        self.in(source_id: Sources::TwitterAccount.all.map {|u| u.id })
      end
    end
    # Sort the content by sort_type
    # @param [String] sort_type
    def sortable(sort_type)
      if sort_type && SORT_TYPE.key?(sort_type.to_sym)
        self.order_by((SORT_TYPE[sort_type.to_sym]))
      else
        self.order_by((SORT_TYPE[:newest]))
      end
    end
    # Exclude domain
    def exclude_domain
      if ::Filters::Content.exists?
        self.not(expanded_url: /(#{::Filters::Content.all.map {|c| c.exclude_domain }.join('|')})/)
      else
        self.all
      end
    end
  end
end