class CollectsJob < ApplicationJob
  queue_as :collects
  def perform(name)
    CollectTag.add(name)
  end
end