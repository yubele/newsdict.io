class Config < ApplicationRecord
  include Mongoid::Document
  include Mongoid::Timestamps
  # key
  field :key, type: String
  # describe
  field :describe, type: String
  # value
  field :value, type: String
  
  # Get config
  def self.[](key)
    return find_by(key: key).value
  end
end