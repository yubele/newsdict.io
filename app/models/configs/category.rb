module Configs
  class Category < ::Config
    has_many :schedules, class_name: "Configs::Schedule"
    has_many :source, class_name: "Source"
  end
end