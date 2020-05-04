class Content < ApplicationRecord
  include Mongoid::Document
  include ContentConcern
  has_one :source
  has_one :user
  field :title, type: String
  field :site_name, type: String
  field :content, type: String
  field :expanded_url, type: String
  # image blob (because active-storage is not support mongoid.)
  field :image_blob, type: BSON::Binary
  field :tags, type: Array
  field :http_status, type: Integer
  field :language_code, type: String
  field :source_id, type: BSON::ObjectId
  field :user_id, type: BSON::ObjectId
  field :count_of_shared, type: Integer
  # unique id of source
  field :unique_id, type: String
  include Mongoid::Timestamps
  belongs_to :source, optional: true
  belongs_to :user, optional: true
  validates_uniqueness_of :unique_id, :allow_nil => true
  SORT_TYPE = {
    :newest => [:created_at, :desc],
    :updated => [:updated_at, :desc],
    :count => [:count_of_shared, :desc]
  }
  # Get tags longer than a certain number of characters
  # @param [Integer] number tag length
  def longer_tags(number = 3)
    tags.map {|tag| tag if tag.length >= number }.compact.reject(&:empty?)
  end
  # If it is true, instance is uniq contents.
  #  Perfect matching `extended_url` or Perfect matching `title`
  # @return [Content] exists content
  def unique?
    if content = Content.where(title: self.title).first || content = Content.where(expanded_url: self.expanded_url).first
      return content
    end
  end
end