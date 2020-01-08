module Contents
  class Web < ::Content
    # Get tags longer than a certain number of characters
    # @param [Integer] tag length
    def longer_tags(number = 3)
      tags.map {|tag| tag if tag.length >= number }.compact.reject(&:empty?)
    end
  end
end
