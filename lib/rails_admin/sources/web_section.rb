RailsAdmin.config do |config|
  config.current_user_method(&:current_user)
  config.model "Sources::WebSection" do
    field :alias do
      visible false
    end
    field :description do
      visible false
    end
    field :user_id do
      visible false
    end
    field :name
    field :category_id
    field :xpath
    field :source_url
    show do
      field :xpath do
        visible true
      end
    end
    edit do
      field :xpath do
        visible false
      end
    end
    list do
      field :source_url do
        pretty_value do
          bindings[:view].content_tag(:a, I18n.t(:edit), href: bindings[:view].main_app.edit_web_section_path(bindings[:object].id), class: "square_btn")
        end
      end
    end
  end
end