module Crowling
  class Crowling::TwitterAccountsJob < BaseJob
    queue_as :default
  
    # Fetch the web each twitter accounts
    def perform
      Sources::TwitterAccount.all.each do |twitter_account|
        twitter_account.user_timeline.each do |tweet|
          tweet.to_h[:entities][:urls].each do |url|
            unless Contents::Web.where(unique_id: tweet.id).exists?
              BaseJob.perform_later(twitter_account, url[:expanded_url], unique_id: tweet.id)
            end
          end
        end
      end
    end
  end
end