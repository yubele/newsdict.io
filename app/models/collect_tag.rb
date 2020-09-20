# Save the tags stored in Content for the tag cloud.
class CollectTag < ApplicationRecord
  CLOUD_LIMIT = 20
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
    # @return [Array]
    def cloud(min_length: 2)
      where(:length.gt => min_length).order_by(count: :desc).limit(self::CLOUD_LIMIT)
    end
  end
end