require 'test_helper'

class TwitterAccountsJobTestJob < ActiveJob::TestCase
  test "the truth" do
    user = FactoryBot.create(:user)
    twitter_account = FactoryBot.create("Sources::TwitterAccount")
    twitter_account.user_id = user.id
    twitter_account.save

    # Enqueued `FetchSourcesJob`
    TwitterAccountsJob.new.perform
    assert_enqueued_jobs 1

    # Enqueued `TwitterAccountsJob`
    TwitterAccountsJob.perform_later
    assert_enqueued_jobs 2
  end
end