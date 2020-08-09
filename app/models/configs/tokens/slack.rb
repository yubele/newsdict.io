module Configs::Tokens
  class Slack < Configs::Token
    field :channel, type: String
    field :username, type: String
    field :text, type: String
    field :webhook, type: String
    field :notify_target_category_id, type: BSON::ObjectId
    field :configs_schedule_id, type: BSON::ObjectId
    validates :channel, length: {minimum: 1, maximum: 255}, presence: true
    validates :username, length: {minimum: 1, maximum: 255}, presence: true
    validates :text, presence: true
    validates :webhook, length: {minimum: 30, maximum: 255}, presence: true
    validates :notify_target_category_id, presence: true
    belongs_to :configs_schedule, class_name: "Configs::Schedule"
    has_many :hooks, class_name: "Configs::Hook", autosave: false
    def notify_target_category_id_enum
      Configs::Category.all.map {|c| [c.key, c.id] }.to_h
    end
    def client
      ::Slack::Notifier.new webhook, channel: channel, username: username
    end
    # Send the messages of contents to slack
    # @param [Contents::Web] contents
    # @return [void]
    def send_message(contents)
      client.ping create_message(contents)
    end
  end
end