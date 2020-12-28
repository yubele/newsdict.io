class Config < ApplicationRecord
  include Mongoid::Document
  field :key, type: String
  include Mongoid::Timestamps
  validates :key, presence: true, uniqueness: true, length: {minimum: 2, maximum: 255}
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
    # Tidy the keys.
    #  - Save the keys if Config has not the same key.
    #  - Delete the keys if self::KEYS has not the key in record. 
    # @return [Boolean]
    def tidy
      self::KEYS.each do |key|
        case where(key: key).count
        when 0
          create(
            key: key
          )
        when 1
          true
        else
          where(key: key).not(id: find_by(key: key).id).delete_all
        end
      end
      all.each do |config|
        unless self::KEYS.include?(config.key.to_sym)
          where(key: config.key).delete_all
        end
      end
    end
  end
end