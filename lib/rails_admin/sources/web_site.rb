RailsAdmin.config do |config|
  config.current_user_method(&:current_user)
  config.model "Sources::WebSite" do
    base do
      fields :alias, :description, :user_id do
        visible false
      end
      fields :name, :category_id
      field :xpath do read_only true end
      field :source_url
    end
    list do
      field :source_url do
        pretty_value do
          bindings[:view].content_tag(:a, I18n.t(:edit), href: bindings[:view].main_app.web_site_path(bindings[:object].id), class: "square_btn")
        end
      end
    end
  end
end