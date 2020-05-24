class Config < ApplicationRecord
  include Mongoid::Document
  validates :key, presence: true, uniqueness: true, length: {minimum: 2, maximum: 255}
  field :key, type: String
  include Mongoid::Timestamps
  # Get config
  def self.[](key)
    if item = find_by(key: key)
      item.value
    end
  end
  # Check Exists
  def self.has_key?(key)
    if find_by(key: key)
      true
    else
      false
    end
  end
end