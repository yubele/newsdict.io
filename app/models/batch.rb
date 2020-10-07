class Batch < ApplicationRecord
  include Mongoid::Document
  field :name, type: String
  include Mongoid::Timestamps
  set_callback  :upsert, :before, :set_updated_at
  validates :name, presence: true, uniqueness: true
  DEFAULT_EXPIRE_ONETIME = 1.minutes.ago
  class << self
    # This meshod is use when you want to run on only one server.
    # @param [String] name Identify name
    # @param [Block] block
    # @return [mixe]
    def single_server(name)
      if find_by(name: name, :updated_at.gt => self::DEFAULT_EXPIRE_ONETIME).nil? &&
          # If this method called at initilizer, Auto timestamp not working.
          new(name: name).upsert
        yield
      end
    end
    # Saves the flag for restart all servers.
    # @return [Boolean]
    def restart_all_server
      new(name: :restart).upsert
    end
    # Hook of restart_all_server
    # @return [Boolean]
    def hook_of_restart_all_server
      cache_key = "#{Rails.application.credentials.secret_key_base}::restart_all_server"
      timestamp = Rails.cache.read(cache_key)
      flag = find_by(name: :restart)
      if flag && (timestamp.nil? || (timestamp <= flag.updated_at.to_i))
        Rails.cache.write(cache_key, Time.zone.now.to_i, expires_in: 24.hours)
        system("bin/rails restart")
        return true
      end
    end
  end
end