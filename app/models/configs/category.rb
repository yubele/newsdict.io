module Configs
  class Category < ::Config
    has_many :schedules, class_name: "Configs::Schedule"
    belongs_to :twitter_account, class_name: "Sources::TwitterAccount"
  end
end