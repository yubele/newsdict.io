module Configs
  class Category < ::Config
    has_many :schedules, class_name: "Configs::Schedule", autosave: false
  end
end