RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Tokens::Slack" do
    fields :key, :channel, :username, :text, :webhook, :notify_target_category_id, :configs_schedule_id
    show do
      field :configs_schedule_id do
        pretty_value do
          if Configs::Schedule.find_by(id: value)
            Configs::Schedule.find_by(id: value).to_s
          end
        end
      end
    end
    edit do
      field :configs_schedule_id, :enum do
        enum do
          Configs::Schedule.where(is_active: true).map {|c| [c.key, c.id] }.to_h
        end
      end
    end
  end
end