module Sources
  class WebSection < ::Source
    include ::SourceUrlConcern
    field :source_url, type: String
    field :xpath, type: String
    validates :name, :category_id, presence: true
    validates :source_url, presence: true, format: { with: URI.regexp }, length: { maximum: 2000 }
    def media_name
      "WebSection"
    end
  end
end