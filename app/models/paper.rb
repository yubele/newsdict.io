class Paper < ApplicationRecord
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :content_ids, type: Array
  field :user_id, type: BSON::ObjectId
  has_and_belongs_to_many :contents
  has_one :user
  belongs_to :user
end