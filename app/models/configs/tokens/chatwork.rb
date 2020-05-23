module Configs::Tokens
  class Chatwork < Configs::Token
    field :room_id, type: Integer
    field :text, type: String
    field :token, type: String
    field :notify_target_category_id, type: BSON::ObjectId
    field :configs_schedule_id, type: BSON::ObjectId
    validates :room_id, length: {minimum: 1, maximum: 255}, presence: true
    validates :text, presence: true
    validates :token, length: {minimum: 30, maximum: 255}, presence: true
    validates :notify_target_category_id, presence: true
    belongs_to :configs_schedule, class_name: "Configs::Schedule"
    def notify_target_category_id_enum
      Configs::Category.all.map {|c| [c.key, c.id] }.to_h
    end
    def client
      ChatWork::Client.new(api_key: token)
    end
  end
end