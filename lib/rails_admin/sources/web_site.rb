RailsAdmin.config do |config|
  config.current_user_method(&:current_user)
  config.model "Sources::WebSite" do
    base do
      fields :alias_name, :description, :user_id do
        visible false
      end
      field :name
      # refs. https://github.com/sferik/rails_admin/wiki/Enumeration#using-the-configuration-approach
      # legacy style because mongoid-enum do not maintend long time.
      field :category_id, :enum do
        enum do
          Configs::Category.all.map {|c| [c.key, c.id] }.to_h
        end
      end
      field :xpath do read_only true end
      field :source_url
    end
  end
end