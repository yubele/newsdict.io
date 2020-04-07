class Config < ApplicationRecord
  include Mongoid::Document
  validates :key, length: {minimum: 4, maximum: 256}, presence: true, uniqueness: true
  validates :description, length: {minimum: 4, maximum: 128}, presence: true, uniqueness: true
  # Key
  field :key, type: String
  # Description
  field :description, type: String
  # Value
  field :value, type: String
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