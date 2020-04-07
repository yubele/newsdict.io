class Source < ApplicationRecord
  include Mongoid::Document
  # Source Name
  field :name, type: String
  # Source Description
  field :description, type: String
  # Relation at User
  field :user_id, type: BSON::ObjectId
  # Last crawling datetime
  field :fetch_at, type: DateTime
  include Mongoid::Timestamps
end