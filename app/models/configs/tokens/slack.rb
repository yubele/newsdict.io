module Configs::Tokens
  class Slack < Configs::Token
    field :channel, type: String
    field :title, type: String
    field :text, type: String
    field :token, type: String
    field :configs_schedule_id, type: BSON::ObjectId
    validates :channel, length: {minimum: 1, maximum: 255}
    validates :title, length: {minimum: 1, maximum: 255}
    validates :text, presence: true
    validates :token, length: {minimum: 30, maximum: 255}, presence: true
    has_one :configs_schedule, class_name: "Configs::Schedule"
    def configs_schedule_id_enum
      Configs::Schedule.where(is_active: true).map {|c| [c.key, c.id] }.to_h
    end
  end
end