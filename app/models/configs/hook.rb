module Configs
  class Hook < Config
    KEYS = [
      :requested_removing,
      :receive_form
    ]
    field :notify_chatwork_id, type: BSON::ObjectId
    field :notify_slack_id, type: BSON::ObjectId
    belongs_to :notify_slack, class_name: "Configs::Tokens::Slack", optional: true
    belongs_to :notify_chatwork, class_name: "Configs::Tokens::Chatwork", optional: true
    def notify_chatwork_id_enum
      Configs::Tokens::Chatwork.all.map {|c| [c.key, c.id] }.to_h
    end
    def notify_slack_id_enum
      Configs::Tokens::Slack.all.map {|c| [c.key, c.id] }.to_h
    end
    class << self
      # Trigger Config::Tokens.
      # @param [Symbol] key key of Configs::KEYS
      # @param [Mixed] data trigger data by key
      # @return void
      def trigger(key, data)
        raise "not found hook" if Configs::Hook::KEYS.find_index(:requested_removing).nil?
        hook = self.find_by(key: key)
        if hook.notify_slack_id.present?
          hook.notify_slack.send_message(data)
        end
        if hook.notify_chatwork_id.present?
          hook.notify_chatwork.send_message(data)
        end
      end
    end
  end
end