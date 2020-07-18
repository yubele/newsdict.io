class Config < ApplicationRecord
  include Mongoid::Document
  validates :key, presence: true, uniqueness: true, length: {minimum: 2, maximum: 255}
  field :key, type: String
  include Mongoid::Timestamps
  class << self
    # Get config value
    # @param [String] key
    # @return [Config]
    def [](key)
      find_by(key: key).to_s
    end
    # Check Exists
    # @param [String] key
    # @return [Boolean]
    def has_key?(key)
      where(key: key).exists?
    end
  end
end