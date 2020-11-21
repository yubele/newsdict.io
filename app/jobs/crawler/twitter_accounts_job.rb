module Crawler
  class TwitterAccountsJob < ::CrawlersJob
    # Fetch the web each twitter accounts
    def perform
      Sources::TwitterAccount.all.each do |twitter_account|
        begin
          twitter_account.user_timeline.each do |tweet|
            tweet.to_h[:entities][:urls].each do |url|
              ::CrawlersJob.perform_later(twitter_account, url[:expanded_url], unique_id: tweet.id)
            end
          end
        rescue Twitter::Error::NotFound
          raise "Twitter::Error::NotFound : #{twitter_account.name}"
        end
      end
    end
  end
end