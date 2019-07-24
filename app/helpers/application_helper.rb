module ApplicationHelper
  # Get the source url
  # @param [BSON::ObjectId]
  # @return string
  def get_source_url(source_id)
    unless source_id.nil?
      source = Source.find(source_id)
      "#{source.source_url}/#{source.name}"
    end
  end
  # Get the name of source
  # @param [BSON::ObjectId]
  # @return string
  def get_name_by_source(source_id)
    Source.find(source_id).name unless source_id.nil?
  end
end
