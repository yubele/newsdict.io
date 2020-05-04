class Source < ApplicationRecord
  include Mongoid::Document
  # Source Name
  field :name, type: String
  field :alias, type: String
  # Source Description
  field :description, type: String
  # Relation at User
  field :user_id, type: BSON::ObjectId
  field :category, type: String
  # Last crawling datetime
  field :fetch_at, type: DateTime
  validates :alias, length: { maximum: 20 } 
  include Mongoid::Timestamps
  def category_enum
    Configs::Category.all.map {|c| c.key }
  end
  def view_name
    if self.alias
      self.alias
    else
      self.name
    end
  end
end