class Configs::MecabDic < ::Config
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
  class << self
    # Get userdics
    # @return [Hash] user dictonary paths
    def userdics
      userdics = Hash.new
      Configs::MecabDic.each do |dic|
        userdics[dic.language_code] = Array.new unless userdics.include?(dic.language_code)
        userdic = File.join(Newsdict::Application.config.path_of_mecab_dict_dir, "#{dic.key}.dic")
        if File.exist?(userdic)
          userdics[dic.language_code] << userdic
        end
      end
      userdics.map {|k,v| [k, v.join(",")]}.to_h
    end
  end
end