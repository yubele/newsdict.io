module Filters
  class IgnoreCrawlContent < ::Filter
    validates :exclude_url, length: {minimum: 3, maximum: 255}, presence: true, uniqueness: true
    field :exclude_url, type: String
    field :message, type: String
  end
end