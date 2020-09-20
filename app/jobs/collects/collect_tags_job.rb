class Collects::CollectTagsJob < ApplicationJob
  def perform
    Content.all.each do |content|
      content.tags.each do |name|
        ::CollectsJob.perform_later(name)
      end
    end
  end
end