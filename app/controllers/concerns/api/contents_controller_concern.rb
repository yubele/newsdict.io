module Api
  module ContentsControllerConcern
    extend ActiveSupport::Concern
    # /api/v*/contents
    # @param [Integer] limit
    # @param [Integer] skip default: 0
    def contents(limit:, skip:0)
      Contents::Web
        .contents
        .skip(skip)
        .limit(limit)
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
            "title" => c.title.truncate(100)
          }).merge({
            "id" => c.id.to_s
          }).merge({
            "longer_tags" => c.longer_tags
          }).merge({
            "source" => c.source.attributes.select { |k,v|
              k.include?("name")
            }.merge({
              "source_url" => c.source.source_url
            })
          }).merge({
            "user" => c.user.attributes.select { |k,v|
              k.include?("name")
            }})
        }
    end
  end
end