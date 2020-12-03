class CollectTagsJob < ApplicationJob
  def perform
    Content.all.each do |content|
      content.tags.each do |name|
        CollectTag.add(name)
      end
    end
  end
end