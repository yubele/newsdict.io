module BindingPostConcern
  include Rails.application.routes.url_helpers
  
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
    "#" + CollectTag.cloud(limit:6, days_ago: 1).map(&:name).join(" #")
  end
  
  # Get paper url of today
  # @return [String]
  def _binding_paper_url_for_today
    time = Time.new
    time.localtime(Time.zone.formatted_offset)
    "#{ENV["PROD_FQDN"]}#{oneday_papers_path(date: time.strftime("%Y%m%d"))}"
  end
  
  # Get paper url of yesterday
  # @return [String]
  def _binding_paper_url_for_yesterday
    time = Time.new
    time.localtime(Time.zone.formatted_offset)
    "#{ENV["PROD_FQDN"]}#{oneday_papers_path(date: (time - 1.day).strftime("%Y%m%d"))}"
  end
  
  # Get date
  # @return [String]
  def _binding_date
    time = Time.new
    time.localtime(Time.zone.formatted_offset)
    time.strftime("%Y/%m/%d")
  end
  
  # Get yesterday
  # @return [String]
  def _binding_yesterday
    time = Time.new
    time.localtime(Time.zone.formatted_offset)
    (time - 1.day).strftime("%Y/%m/%d")
  end
end