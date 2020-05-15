# Deprecated class
module Sources
  class WebUrl < ::Source
    include ::SourceWebSiteConcern
    field :source_url, type: String
    validates :name, :category_id, presence: true
    validates :source_url, presence: true, format: { with: URI.regexp }, length: { maximum: 2000 }
    def media_name
      "WebPage"
    end
  end
end