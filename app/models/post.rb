class Post < ApplicationRecord
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :body, type: String
  field :hook_id, type: BSON::ObjectId
  field :schedule_id, type: BSON::ObjectId
  validates :name, presence: true
  belongs_to :hook, class_name: "Configs::Hook", required: false
  belongs_to :schedule, class_name: "Configs::Schedule", required: false
end