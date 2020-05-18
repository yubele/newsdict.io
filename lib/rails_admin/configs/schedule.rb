RailsAdmin.config do |config|
  config.model "Configs::Schedule" do
    fields :key, :description, :notify_at, :enable
    edit do
      field :notify_at do
        render do
          bindings[:view].render :partial => 'rails_admin/main/partials/time_of_day', :locals => {:field => self, :form => bindings[:form]}
        end
      end
    end
  end
end