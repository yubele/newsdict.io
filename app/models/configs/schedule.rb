module Configs
  class Schedule < ::Config
    field :description, type: String
    # Use as a TimeOfDay object.
    field :notify_at, type: DateTime
    field :enable, type: Boolean
  end
end