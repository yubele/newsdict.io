module Filters
  class HiddenContent < ::Filter
    validates :exclude_url, length: {minimum: 3, maximum: 255}, presence: true, uniqueness: true, if: -> { exclude_title.blank? }
    validates :exclude_title, length: {minimum: 3, maximum: 255}, presence: true, uniqueness: true, if: -> { exclude_url.blank? }
    field :exclude_url, type: String
    field :exclude_title, type: String
  end
end