class Source < ApplicationRecord
  include Mongoid::Document
  # Source Name
  field :name, type: String
  field :alias, type: String
  # Source Description
  field :description, type: String
  # Relation at User
  field :user_id, type: BSON::ObjectId
  field :category_id, type: BSON::ObjectId
  # Last crawling datetime
  field :fetch_at, type: DateTime
  validates :alias, length: { maximum: 20 }
  include Mongoid::Timestamps
  has_many :content, dependent: :destroy
  def category_id_enum
    Configs::Category.all.map {|c| [c.key, c.id] }.to_h
  end
  def view_name
    if self.alias
      self.alias
    else
      self.name
    end
  end
end