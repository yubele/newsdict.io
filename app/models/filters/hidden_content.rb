module Filters
  class HiddenContent < ::Filter
    validates :exclude_url, length: {maximum: 255}, uniqueness: true, if: -> { exclude_title.blank? }
    validates :exclude_title, length: {maximum: 255}, uniqueness: true, if: -> { exclude_url.blank? }
    field :exclude_url, type: String
    field :exclude_title, type: String
  end
end