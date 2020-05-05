module Api
  module ContentsControllerConcern
    include ApplicationHelper
    extend ActiveSupport::Concern
    # /api/v*/contents
    # @param [Integer] limit default: 25
    # @param [Integer] skip default: 0
    # @param [String] sort default: Content::SORT_TYPE[:updated_at]
    # @param [String] category 
    def contents(limit: 25, skip:0, sort: Content::SORT_TYPE[:updated_at], category: nil)
      Contents::Web
        .contents(category_id: Configs::Category.find_by(key: category).id)
        .sortable(sort)
        .exclude_domain
        .limit(limit)
        .skip(skip)
        .map { |c|
          c.attributes.select { |k,v|
            k.include?("title") ||
            k.include?("site_name") ||
            k.include?("expanded_url") ||
            k.include?("language_code") ||
            k.include?("count_of_shared") ||
            k.include?("created_at") ||
            k.include?("updated_at")
          }.merge({
            "created_at" => in_time_zone(c.created_at)
          }).merge({
            "content" => c.content.truncate(100)
          }).merge({
            "id" => c.id.to_s
          }).merge({
            "longer_tags" => tag_element(c.longer_tags)
          }).merge({
            "source" => {
              "name" => c.source.name,
              "view_name" => c.source.view_name,
              "source_url" => c.source.source_url
          }})
        }
    end
  end
end