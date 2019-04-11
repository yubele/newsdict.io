class Source < ApplicationRecord
  include Mongoid::Document
  include Mongoid::Timestamps
  # Source Name
  field :name, type: String
  # Source Description
  field :description, type: String
  # relation at User
  field :user_id, type: Object
  # last crawling datetime
  field :fetch_at, type: DateTime
end