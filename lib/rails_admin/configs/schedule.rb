RailsAdmin.config do |config|
  config.model "Configs::Schedule" do
    fields :key, :description, :hour, :min, :wday, :is_active
    list do
      field :wday do
        pretty_value do
          if value == -1
            I18n.t(:everyday)
          else
            I18n.t("date.abbr_day_names")[value.to_i]
          end
        end
      end
      field :hour do
        pretty_value do
          if value == -1
            I18n.t(:everyhour)
          else
            I18n.t("datetime.hour", hour: value)
          end
        end
      end
      field :min do
        pretty_value do
          if value == -1
            I18n.t(:everymin)
          else
            I18n.t("datetime.min", min: value)
          end
        end
      end
    end
  end
end