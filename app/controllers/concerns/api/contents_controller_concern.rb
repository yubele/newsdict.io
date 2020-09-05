module Api
  module ContentsControllerConcern
    include ApplicationHelper
    extend ActiveSupport::Concern
    # Use api and timeline_controller
    # @param [Integer] limit default: 25
    # @param [Integer] skip default: 0
    # @param [String] sort default: Content::SORT_TYPE[:updated_at]
    # @param [String] category
    # @param [String] tag sarch by tag
    # @rerurn [JSON]
    def contents(limit: 25, skip:0, sort: :updated_at, category: nil, tag: nil)
      category_id = Configs::Category.find_by(key: category).id if Configs::Category.find_by(key: category)
      content = Contents::Web
      if tag
        content = Contents::Web.search_by_tag(tag)
      end
      content
        .contents(category_id: category_id)
        .sortable(sort)
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
            "created_at" => in_time_zone(c.created_at),
            "updated_at" => in_time_zone(c.updated_at),
            "content" => c.content.truncate(100),
            "id" => c.id.to_s,
            "longer_tags" => tag_element(c.longer_tags),
            "source" => {
              "name" => c.source.name,
              "view_name" => c.source.view_name,
              "source_url" => c.source.source_url
            },
            "user" => {
              "username" => c.user ? c.user.username : ""
            }
          })
        }.to_json
    end
  end
end