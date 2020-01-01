class Config < ApplicationRecord
  include Mongoid::Document
  include Mongoid::Timestamps
  validates :key, length: {minimum: 4, maximum: 256}, presence: true, uniqueness: true
  validates :describe, length: {minimum: 4, maximum: 128}, presence: true, uniqueness: true
  # key
  field :key, type: String
  # describe
  field :describe, type: String
  # value
  field :value, type: String
  
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