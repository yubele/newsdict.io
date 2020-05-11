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
    field :source_url
    list do
      field :source_url do
        pretty_value do
          bindings[:view].content_tag(:a, I18n.t(:edit), href: bindings[:view].main_app.edit_web_section_path(bindings[:object].id), class: "square_btn")
        end
      end
    end
  end
end