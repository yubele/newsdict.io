class Source < ApplicationRecord
  include Mongoid::Document
  # Source Name
  field :name, type: String
  # deprecated
  field :alias, type: String
  field :alias_name, type: String
  # Source Description
  field :description, type: String
  # Relation at User
  field :user_id, type: BSON::ObjectId
  field :category_id, type: BSON::ObjectId
  # Last crawling datetime
  field :fetch_at, type: DateTime
  field :icon_blob, type: BSON::Binary
  validates :alias, length: { maximum: 20 }
  include Mongoid::Timestamps
  belongs_to :category, class_name: "Configs::Category", required: false
  has_many :content, dependent: :destroy
  # Get name
  # @return [String]
  def view_name
    if self.alias
      self.alias
    elsif self.alias_name
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