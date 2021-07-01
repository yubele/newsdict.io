class Source < ApplicationRecord
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user, class_name: "User", required: false
  belongs_to :category, class_name: "Configs::Category"
  has_many :content, dependent: :destroy
  
  field :name, type: String
  field :alias_name, type: String
  field :description, type: String
  field :fetch_at, type: DateTime
  field :icon_blob, type: BSON::Binary

  # Get name
  # @return [String]
  def view_name
    if self.alias_name
      self.alias_name
    else
      self.name
    end
  end
  
  private
    def save_icon_blob_from_url(url)
      tmp_file = "/tmp/#{Digest::SHA1.hexdigest(url)}"
      agent = Mechanize.new { |_agent| _agent.user_agent = WebStat::Configure.get["user_agent"] }
      agent.get(url).save_as(tmp_file)
      self.icon_blob = BSON::Binary.new(File.read(tmp_file))
      File.unlink(tmp_file)
      self.save
    end
end