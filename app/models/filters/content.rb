module Filters
  class Content < ::Filter
    validates :exclude_domain, length: {minimum: 3, maximum: 63}, presence: true, uniqueness: true
    field :exclude_domain, type: String
  end
end