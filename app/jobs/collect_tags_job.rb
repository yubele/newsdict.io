class CollectTagsJob < ApplicationJob
  def perform
    Content.all.each do |content|
      content.tags.each do |name|
        CollectTag.add(name)
      end
    end
    # clean tags
    CollectTag.all.each do |tag|
      tag.delete if Content::search_by_tag(tag: tag.name).count == 0
    end
  end
end