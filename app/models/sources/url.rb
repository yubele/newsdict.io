# Deprecated class
module Sources
  class Url < ::Source
    include ::SourceWebUrlConcern
    field :source_url, type: String
    validates :name, :category_id, presence: true
    validates :source_url, presence: true, format: { with: URI.regexp }, length: { maximum: 2000 }
    def media_name
      "WebPage"
    end
  end
end