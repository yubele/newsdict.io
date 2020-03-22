module ApplicationHelper
  # Count user
  def count_user
    User.all.count
  end
  # Tag elements
  # @param [Array] tags Tag names
  # @param [Integer] limit Limit of count
  def tag_element(tags, limit=5)
    element = String.new
    tags.first(5).each do |tag|
      element << "<span class='tag is-dark'>#{tag}</span>"
    end
    element
  end
  # View date
  # @param [Datetime] datetime
  def in_time_zone(datetime)
    Time.at(datetime).in_time_zone
  end
end
