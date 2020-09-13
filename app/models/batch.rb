class Batch < ApplicationRecord
  include Mongoid::Document
  field :name, type: String
  include Mongoid::Timestamps
  validates :name, presence: true, uniqueness: true, length: {minimum: 2, maximum: 255}
  DEFAULT_EXPIRE_ONETIME = 1.minutes.ago
  class << self
    def onetime(name)
      if find_by(:name => name, :updated_at.gt => self::DEFAULT_EXPIRE_ONETIME).nil?
        batch = find_by(name: name) || new(name: name, created_at: Time.now)
        # If this method called at initilizer, Auto timestamp not working.
        batch.updated_at = Time.now
        batch.save
        yield
      end
    end
  end
end