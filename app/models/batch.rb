class Batch < ApplicationRecord
  include Mongoid::Document
  field :name, type: String
  include Mongoid::Timestamps
  validates :name, presence: true, uniqueness: true
  DEFAULT_EXPIRE_ONETIME = 1.minutes.ago
  class << self
    def onetime(name)
      if find_by(name: name, :updated_at.gt => self::DEFAULT_EXPIRE_ONETIME).nil? &&
          # If this method called at initilizer, Auto timestamp not working.
          find_or_create_by(name: name)
        yield
      end
    end
  end
end