module Configs::Tokens
  class Chatwork < Configs::Token
    field :room_id, type: Integer
    field :text, type: String
    field :token, type: String
    validates :room_id, length: {minimum: 1, maximum: 255}, presence: true
    validates :text, presence: true
    validates :token, length: {minimum: 30, maximum: 255}, presence: true
    has_many :hooks, class_name: "Configs::Hooks", autosave: false
    def notify_target_category_id_enum
      Configs::Category.all.map {|c| [c.key, c.id] }.to_h
    end
    def client
      ChatWork::Client.new(api_key: token)
    end
    # Send the messages of contents to chatwork
    # @param [Content] contents
    # @return [void]
    def send_message(contents)
      client.create_message(
        room_id: room_id,
        body: create_message(contents))
    end
  end
end