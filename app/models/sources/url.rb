module Sources
  class Url < ::Source
    include ::SourceUrlConcern
    field :url, type: String
    def media_name
      "WebPage"
    end
  end
end