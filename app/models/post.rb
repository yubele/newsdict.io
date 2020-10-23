class Post < ApplicationRecord
  include Rails.application.routes.url_helpers
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :body, type: String
  field :hook_id, type: BSON::ObjectId
  field :schedule_id, type: BSON::ObjectId
  validates :name, presence: true
  belongs_to :hook, class_name: "Configs::Hook", required: false
  belongs_to :schedule, class_name: "Configs::Schedule", required: false
  # Bind variable of body
  def bind_body
    body.scan(/{(.*?)}/).each do |names|
      name = names.first
      if respond_to?("_binding_#{name}")
        body.gsub!("{#{name}}", send("_binding_#{name}"))
      end
    end
    body
  end
  # Get the hash tags of the recent tags
  # @return [String]
  def _binding_recent_tags
    "#" + CollectTag.cloud.limit(3).map(&:name).join(" #")
  end
  # Get paper url of today
  # @return [String]
  def _binding_paper_url_for_today
    time = Time.new
    time.localtime(Time.zone.formatted_offset)
    "#{ENV["PROD_FQDN"]}#{paper_oneday_path(date: time.strftime("%Y%m%d"))}"
  end
  # Get date
  # @return [String]
  def _binding_date
    time = Time.new
    time.localtime(Time.zone.formatted_offset)
    time.strftime("%Y/%m/%d")
  end
end