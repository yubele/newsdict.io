# Save the tags stored in Content for the tag cloud.
class CollectTag < ApplicationRecord
  DEFAULT_CLOUD_LIMIT = 20
  include Mongoid::Document
  field :name, type: String
  field :length, type: Integer
  field :count, type: Integer
  include Mongoid::Timestamps
  validates :name, presence: true, uniqueness: true
  class << self
    # Add tag
    # @param [String] name tag name
    # @return [Boolean]
    def add(name)
      where(name: name, length: name.length).first_or_create.inc(count: 1)
    end
    # Tag Cloud
    # @param [Integer] min_length Minimum tag name length
    # @param [Integer] Get the tag for x days.
    # @param [Integer] max_length 
    # @return [Array]
    def cloud(min_length: 3, days_ago: 30, max_length: 10, limit: DEFAULT_CLOUD_LIMIT)
      content = where(:length.gte => min_length, :updated_at.gte => (Time.zone.now - days_ago.days)).order_by(count: :desc).limit(limit)
      content = content.lte(length: max_length) if max_length
      content
    end
  end
end