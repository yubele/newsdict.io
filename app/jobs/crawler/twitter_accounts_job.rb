module Crawler
  class TwitterAccountsJob < ::CrawlersJob
    # Fetch the web each twitter accounts
    def perform
      (Sources::TwitterAccount.all + Sources::Relations::TwitterAccount.all).each do |twitter_account|
        begin
          twitter_account.user_timeline.each do |tweet|
            tweet.to_h[:entities][:urls].each do |url|
              unless ::Filters::IgnoreCrawlContent.where(exclude_url: url[:expanded_url]).exists?
                ::CrawlersJob.perform_later(twitter_account, url: url[:expanded_url], unique_id: tweet.id, shared_text: tweet.text)
              end
            end
          end
        rescue Twitter::Error::NotFound
          raise "Twitter::Error::NotFound : #{twitter_account.name}"
        end
      end
    end
  end
end