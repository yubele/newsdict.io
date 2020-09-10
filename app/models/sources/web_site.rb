module Sources
  class WebSite < ::Source
    field :source_url, type: String
    field :xpath, type: String, default: ""
    validates :name, :category_id, presence: true
    validates :source_url, presence: true, format: { with: URI.regexp }, length: { maximum: 255 }
    # Get media name
    # @return [String] media_name
    def media_name
      "WebSite"
    end
    # Get external urls
    def urls
      hrefs = Array.new
      ::Nokogiri::HTML(WebDriverHelper.get_source(source_url))
      .xpath("#{xpath}//a/@href").map {|a| a.value unless a.value.blank? }
      .uniq.each do |href|
        hrefs << ApplicationHelper.create_full_url(source_url, href)
      end
      hrefs
    end
    # Check if it is updated.
    # This is written here because it must be determined for each Source model.
    # @param [Contents::Web] content
    # @param [Hash] Contents::Web attributes
    # @return [Boolean]
    def update?(content, attrs)
      content.content != attrs[:content]
    end
    # Return icon image.
    # @return [BSON::Binary] image
    def icon
      unless icon_blob
        html = WebDriverHelper.get_source(source_url)
        if ::Nokogiri::HTML(html).xpath('//link[@rel="apple-touch-icon"]/@href').first
          path = ::Nokogiri::HTML(html).xpath('//link[@rel="apple-touch-icon"]/@href').first.value
        else
          path = ::Nokogiri::HTML(html).xpath('//link[@rel="shortcut icon"]/@href').first.value
        end
        url = ApplicationHelper.create_full_url(source_url, path)
        self.save_icon_blob_from_url(url)
      end
      self.icon_blob
    end
  end
end