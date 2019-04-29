class TwitterAccountsJob < FetchSourcesJob
  queue_as :default

  # Fetch the web each twitter accounts
  def perform
    Sources::TwitterAccount.all.each do |twitter_account|
      FetchSourcesJob.perform_later(twitter_account)
    end
  end
end