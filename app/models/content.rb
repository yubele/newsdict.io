class Content < ApplicationRecord
  include Mongoid::Document
  include Mongoid::Timestamps
  include ContentConcern
  field :title, type: String
  field :site_name, type: String
  field :content, type: String
  field :expanded_url, type: String
  # image blob (because active-storage is not support mongoid.)
  field :image_blob, type: BSON::Binary
  field :tags, type: Array
  field :language_code, type: String
  field :source_id, type: BSON::ObjectId
  field :user_id, type: BSON::ObjectId
  field :count_of_shared, type: Integer
  # Get the records
  # @param order default :desc
  # @param limit default: 50
  # @param skip default: 0
  def self.contents(order: :desc, skip: 0, limit: 50)
    self.in(source_id: Sources::TwitterAccount.all.map {|u| u.id })
      .order_by(created_at: order)
      .skip(skip)
      .limit(limit)
  end
end