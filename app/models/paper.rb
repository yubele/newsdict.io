class Paper < ApplicationRecord
  include Mongoid::Document
  field :content_ids, type: Array
  field :user_id, type: BSON::ObjectId
  has_and_belongs_to_many :contents
  has_one :user
end