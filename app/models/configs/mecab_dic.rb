module Configs
  # keyword list for macab dictionary
  class MecabDic < ::Config
    validates :url, length: {minimum: 4, maximum: 256}, presence: true, uniqueness: true
    validates :regex_for_ignore_line, length: {maximum: 128}, presence: true
    validates :language_code, length: {minimum: 2, maximum: 2}, presence:true
    field :description, type: String
    # Url of keyword list
    field :url, type: String
    # Regex for ignore line
    field :regex_for_ignore_line, type: String
    # Language code
    #  https://en.wikipedia.org/wiki/ISO_639-1
    field :language_code, type: String
    field :is_header, type: Boolean
    def key
      _id
    end
  end
end