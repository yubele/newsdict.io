module ApplicationHelper
  # Get the name of source
  # @param [BSON::ObjectId]
  def find_name_by_source(source_id)
    Source.find(source_id).name unless source_id.nil?
  end
end
