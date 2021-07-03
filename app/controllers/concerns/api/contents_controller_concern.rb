module Api
  module ContentsControllerConcern
    include ApplicationHelper
    extend ActiveSupport::Concern
    # Use api and portal_controller
    # @param [Integer] limit default: 25
    # @param [Integer] skip default: 0
    # @param [String] sort default: Content::SORT_TYPE[:updated_at]
    # @param [String] category
    # @param [String] tag sarch by tag
    # @param [String] search search word
    # @rerurn [JSON]
    def contents(limit: Newsdict::Application.config.count_of_content_per_page, skip:0, sort: :last_modified_at, category: nil, tag: nil, search: nil, model: Content, is_json: true)
      options = Hash.new
      if Configs::Category.find_by(key: category)
        options[:category_id] = Configs::Category.find_by(key: category).id
      end
      if tag
        content = model.search_by_tag(tag.split(","))
      elsif search
        content = model.search_by_mixed(search)
      else
        content = model
      end
      hash = content
        .contents(**options)
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
            k.include?("last_modified_at") ||
            k.include?("created_at") ||
            k.include?("updated_at")
          }.merge({
            "expanded_domain" => URI.parse(c.expanded_url).host,
            "last_modified_at" => c.last_modified_at.nil? ? in_time_zone(c.updated_at) : in_time_zone(c.last_modified_at),
            "last_modified_at_human_format" => c.last_modified_at.nil? ? c.updated_at.to_s(:human) : c.last_modified_at.to_s(:human),
            "created_at" => in_time_zone(c.created_at),
            "created_at_human_format" => c.created_at.to_s(:human),
            "updated_at" => in_time_zone(c.updated_at),
            "content_text" => c.language_code == "ja" ? c.content_text.truncate(80) : c.content_text.truncate(160),
            "shared_text" => c.shared_text.nil? ? "" : c.shared_text.truncate(50),
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
        if is_json
          JSON.parse(hash, object_class: OpenStruct)
        else
          hash
        end
    end
  end
end