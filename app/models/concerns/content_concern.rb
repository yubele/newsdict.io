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
        :http_status => web_stat[:status],
        :language_code => web_stat[:language_code],
        :tags => web_stat[:tags],
        :source_id => object.id,
        :user_id => object.user_id
      }
      # image
      unless web_stat[:eyecatch_image_path].nil?
        blob = File.read(web_stat[:eyecatch_image_path])
        begin
          # Binary
          image = MiniMagick::Image.read(blob)
          image.resize "128x"
          attrs[:image_blob] = BSON::Binary.new(image.to_blob)
        rescue
          # Svg
          attrs[:image_svg] = blob
        end
      end
      attrs
    end
    # Save a content from job
    # @param [Hash] attrs
    # @return [void] 
    def save_form_job(attrs)
      already_content = Contents::Web.unique?(url: attrs[:exclude_url], title: attrs[:title])
      # Check duplicated contents
      if already_content && already_content.source.update?(already_content, attrs)
        already_content.update_attributes(attrs)
        already_content.inc(count_of_shared: 1)
      else
        # Translate
        if attrs[:language_code] != ENV["default_locale"] && EasyTranslate.api_key.present?
          attrs[:title] = EasyTranslate.translate(attrs[:title], :to => ENV["default_locale"])
        end
        content = Contents::Web.new(attrs)
        content.count_of_shared = 1
        content.save
      end
    end
    # Get the records
    # @param order default :desc
    # @param category_id default: nil
    # @return [Contents::Web] 
    def contents(order: :desc, category_id: nil, name: nil)
      if name
        collection = self.in(source_id: Source.find_by(name: name))
      elsif category_id
        collection = self.in(source_id: Source.where(category_id: category_id).map {|u| u.id })
      else
        collection = self.in(source_id: Source.all.map {|u| u.id })
      end
      collection = collection.where(http_status: "200")
      if ::Filters::Content.exists?
        collection.not(expanded_url: /(#{::Filters::Content.all.map {|c| c.exclude_url }.join('|')})/)
      else
        collection.all
      end
    end
    # Sort the content by sort_type
    # @param [String|Symbol] sort_type
    # @return [Contents::Web] 
    def sortable(sort_type=:updated_at)
      if Content::SORT_TYPE.key?(sort_type.to_sym)
        sort_type_sym = sort_type.to_sym
      end
      order_by(*Content::SORT_TYPE[sort_type_sym])
    end
    # Get the data of between gt and lte
    # @params [String] gt 
    # @params [String] lte
    # @return [Contents::Web] 
    def term(gt, lte, key = :updated_at)
      gt(key => gt).lte(key => lte)
    end
    # If it is true, instance is uniq contents.
    #  Perfect matching `extended_url` or Perfect matching `title`
    # @param [String] url
    # @param [String] title
    # @return [Content] exists content
    def unique?(url: nil, title: nil)
      where(expanded_url: url).first || where(title: title).first
    end
  end
end