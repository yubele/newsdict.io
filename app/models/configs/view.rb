module Configs
  class View < ::Config
    validates :description, length: { maximum: 100 }
    field :description, type: String
    field :value, type: String
  end
end