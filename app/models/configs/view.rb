module Configs
  class View < ::Config
    validates :description, length: { maximum: 100 }
    field :description, type: String
    field :value, type: String
    KEYS = {
      head: 'Insert this code as high in the <head> tag',
      after_body: 'Insert this code immediately after the opening <body> tag',
      end_body: 'Insert this code immediately end the closing <body> tag'
    }
    def to_s
      send(:value).to_s
    end
  end
end