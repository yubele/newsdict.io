module ContentConcern
  extend ActiveSupport::Concern
  # Get tags longer than a certain number of characters
  # @param [Integer] number tag length
  def longer_tags(number = 3)
    tags.map {|tag| tag if tag.length >= number }.compact.reject(&:empty?)
  end
end