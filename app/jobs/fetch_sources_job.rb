class FetchSourcesJob < ApplicationJob
  queue_as :default

  # Fetch the web pages by url
  # @param [Source] source
  def perform(source)
    SourceRepository.new(source).active_job
  end
end