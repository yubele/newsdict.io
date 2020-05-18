module Configs::Tokens
  class Chatwork < ::Config
    field :room_id, type: Integer
    field :text, type: String
    field :token, type: String
    field :is_default, type: Boolean
    validates :room_id, length: {minimum: 1, maximum: 255}, presence: true
    validates :text, presence: true
    validates :token, length: {minimum: 30, maximum: 255}, presence: true
  end
end