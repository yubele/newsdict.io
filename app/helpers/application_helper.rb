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
  # Create full url from relative path on url.
  def create_full_url(url, relative_path)
    uri = URI.parse(url)
    if [80, 443].include?(uri.port)
      fqdn = "#{uri.scheme}://#{uri.host}"
    else
      fqdn = "#{uri.scheme}://#{uri.host}:#{uri.port}"
    end
    if relative_path.match(Regexp.new("^//")) || relative_path.match(Regexp.new("^http"))
      relative_path
    elsif relative_path.match(Regexp.new("^/"))
      "#{fqdn}#{relative_path}"
    elsif relative_path.match(Regexp.new("^\."))
      "#{fqdn}/#{relative_path}"
    else
      "#{fqdn}#{uri.path}/#{relative_path}"
    end
  end
  module_function :create_full_url
end
