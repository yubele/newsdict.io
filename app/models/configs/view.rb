module Configs
  class View < ::Config
    validates :key, length: { maximum: 20 }
    validates :description, length: { maximum: 100 }
  end
end