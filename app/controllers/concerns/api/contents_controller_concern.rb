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
    # @param [String] search search word
    # @rerurn [JSON]
    def contents(limit: 25, skip:0, sort: :created_at, category: nil, tag: nil, search: nil)
      category_id = Configs::Category.find_by(key: category).id if Configs::Category.find_by(key: category)
      content = Content
      if tag
        content = Content.search_by_tag(tag)
      elsif search
        content = Content.search_by_mixed(search)
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
            "created_at_human_format" => c.created_at.to_s(:human),
            "updated_at" => in_time_zone(c.updated_at),
            "content" => c.content.truncate(100),
            "id" => c.id.to_s,
            "longer_tags" => tag_element(c.longer_tags),
            "source" => {
              "id" => c.source.id.to_s,
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