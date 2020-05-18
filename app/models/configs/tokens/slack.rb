module Configs::Tokens
  class Slack < ::Config
    field :channel, type: String
    field :title, type: String
    field :text, type: String
    field :token, type: String
    field :is_default, type: Boolean
    validates :channel, length: {minimum: 1, maximum: 255}
    validates :title, length: {minimum: 1, maximum: 255}
    validates :text, presence: true
    validates :token, length: {minimum: 30, maximum: 255}, presence: true
  end
end