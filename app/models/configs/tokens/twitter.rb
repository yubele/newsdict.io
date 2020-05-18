module Configs::Tokens
  class Twitter < Configs::Token
    field :consumer_key, type: String
    field :consumer_secret, type: String
    field :access_token, type: String
    field :access_secret, type: String
    validates :consumer_key, length: {minimum: 1, maximum: 255}, presence: true
    validates :consumer_secret, length: {minimum: 1, maximum: 255}, presence: true
    validates :access_token, length: {minimum: 1, maximum: 255}, presence: true
    validates :access_secret, length: {minimum: 1, maximum: 255}, presence: true
  end
end