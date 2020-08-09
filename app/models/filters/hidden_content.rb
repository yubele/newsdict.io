module Filters
  class HiddenContent < ::Filter
    validates :exclude_url, length: {maximum: 255}, uniqueness: true, if: -> { exclude_title.blank? }
    validates :exclude_title, length: {maximum: 255}, uniqueness: true, if: -> { exclude_url.blank? }
    field :exclude_url, type: String
    field :exclude_title, type: String
    class << self
      # Regexp of field
      # @param [Symbol] column_name
      # @return [nil|Regexp]
      def regexp(column_name)
        Regexp.new("(" << ::Filters::HiddenContent.not(column_name => nil).not(column_name => "").map { |filter|
            "^#{Regexp.escape(filter.send(column_name))}$"
          }.join('|') << ")") if ::Filters::HiddenContent.not(column_name => nil).not(column_name => "").present?
      end
    end
  end
end