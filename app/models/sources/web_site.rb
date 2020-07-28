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
      uri = URI.parse(source_url)
      if [80, 443].include?(uri.port)
        fqdn = "#{uri.scheme}://#{uri.host}"
      else
        fqdn = "#{uri.scheme}://#{uri.host}:#{uri.port}"
      end
      hrefs = Array.new
      ::Nokogiri::HTML(WebDriverHelper.get_source(source_url))
      .xpath("#{xpath}//a/@href").map {|a| a.value unless a.value.blank? }
      .uniq.each do |href|
        if href.match(::Regexp.new("^//"))
          hrefs << "#{uri.scheme}:#{href}"
        elsif href.match(::Regexp.new("^/"))
          hrefs << "#{fqdn}#{href}"
        elsif href.match(::Regexp.new("^\\."))
          hrefs << "#{fqdn}/#{href}"
        else
          hrefs << href
        end
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
  end
end