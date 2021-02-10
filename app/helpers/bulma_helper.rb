module BulmaHelper
  TAGCLOUD_CLASSES = ['is-small', 'is-normal', 'is-medium', 'is-large']
  # create tag cloud elements
  # @return [String]
  def create_tag_cloud
    tags = CollectTag.cloud(limit: 100)
    unit = tags.to_a.count / TAGCLOUD_CLASSES.count
    elements = []
    tags.each_with_index do |tag, index|
      element = "<span class='tag "
      element << TAGCLOUD_CLASSES[((index) / unit).floor]
      element << "'>#{link_to tag.name, tag_path(tag.name)}</span>"
      elements << element
    end
    elements.shuffle.join.html_safe
  end
end
