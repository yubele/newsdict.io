module Configs
  class Hook < Config
    KEYS = [
      :requested_removing,
      :receive_form
    ]
    field :chatwork_id, type: BSON::ObjectId
    field :slack_id, type: BSON::ObjectId
    belongs_to :slack, class_name: "Configs::Tokens::Slack", optional: true
    belongs_to :chatwork, class_name: "Configs::Tokens::Chatwork", optional: true
    def chatwork_id_enum
      Configs::Tokens::Chatwork.all.map {|c| [c.key, c.id] }.to_h
    end
    def slack_id_enum
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
        if hook.slack_id.present?
          hook.slack.send_message(data)
        end
        if hook.chatwork_id.present?
          hook.chatwork.send_message(data)
        end
      end
    end
  end
end