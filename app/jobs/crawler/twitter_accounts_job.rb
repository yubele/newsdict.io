module Crawler
  class TwitterAccountsJob < ::CrawlersJob
    # Fetch the web each twitter accounts
    def perform
      Sources::TwitterAccount.all.each do |twitter_account|
        twitter_account.user_timeline.each do |tweet|
          tweet.to_h[:entities][:urls].each do |url|
            ::CrawlersJob.perform_later(twitter_account, url[:expanded_url], unique_id: tweet.id)
          end
        end
      end
    end
  end
end