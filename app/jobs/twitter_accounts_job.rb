class TwitterAccountsJob < FetchSourcesJob
  queue_as :default

  # Fetch the web each twitter accounts
  def perform
    Sources::TwitterAccount.all.each do |twitter_account|
      twitter_account.urls.each do |url|
        FetchSourcesJob.perform_later(twitter_account, url)
      end
    end
  end
end