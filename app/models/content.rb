class Content < ApplicationRecord
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :site_name, type: String
  field :content, type: String
  field :expanded_url, type: String
  field :eyecatch_image_path, type: String
  field :tags, type: Array
  field :source_id, type: BSON::ObjectId
  field :user_id, type: BSON::ObjectId
end