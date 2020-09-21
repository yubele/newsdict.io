class Batch < ApplicationRecord
  include Mongoid::Document
  field :name, type: String
  include Mongoid::Timestamps
  validates :name, presence: true, uniqueness: true, length: {minimum: 2, maximum: 255}
  DEFAULT_EXPIRE_ONETIME = 1.minutes.ago
  class << self
    def onetime(name)
      if find_or_create_by(:name => name, :updated_at.gt => self::DEFAULT_EXPIRE_ONETIME).persisted?
        yield
      end
    end
  end
end