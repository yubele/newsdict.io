class Config < ApplicationRecord
  include Mongoid::Document
  validates :key, presence: true, uniqueness: true
  field :key, type: String
  field :description, type: String
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