module SourceUrlConcern
  extend ActiveSupport::Concern

  # Get external urls
  def urls
    # @todo: implements
    ["https://newsdict.io", "https://newsdict.blog"]
  end
  
  class_methods do
  end
end