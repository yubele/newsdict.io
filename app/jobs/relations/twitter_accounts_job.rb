class Relations::TwitterAccountsJob < ApplicationJob
  def perform
    Sources::TwitterAccount.all.each do |twitter_account|
      begin
        twitter_account.relation_accounts
      rescue Twitter::Error::NotFound
        raise "Twitter::Error::NotFound : #{twitter_account.name}"
      end
    end
  end
end