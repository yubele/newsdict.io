module AutoloaderHelper
  # render partial: _article
  # @param [Collection] contents
  # @return [String] article html
  def partial_article(contents)
    html = String.new
    contents.each do |content|
      html += render partial: 'partials/article', locals: {
        content_url: content_path(content.id),
        img_src: "/img/#{content.id}",
        content: content
      }
    end
    raw(html)
  end

  # render partial: _article for vuejs
  # @return [String] article html
  def partial_article_for_vuejs
    vue_for_content = {
      "id" => "content.id",
      "title" => "content.title",
      "content" => "content.content",
      "longer_tags" => "content.longer_tags",
      "expanded_url" => "content.expanded_url",
      "created_at" => "content.created_at",
      "created_at_human_format" => "content.created_at_human_format",
      "source" => {
        "source_url" => "content.source.source_url",
        "name" => "content.source.name",
        "view_name" => "content.source.view_name"
      }}
    raw render partial: 'partials/article', locals: {
      vuejs_suffix: Newsdict::Application.config.vuejs_suffix,
      img_src:"'/img/' + content.id",
      content_url: "'/contents/' + content.id + '/'",
      content: JSON.parse(vue_for_content.to_json, object_class: OpenStruct)
      }
  end
  # wrapper of vue_content_tag of VueRailsFormBuilder::TagHelper
  # @param [Symbol] name of element
  # @param [Hash] content for view
  # @param [Hash or String] contents or attributes of element
  # @param [Boolean] open
  # @param [Boolean] escape
  # @param [Proc] block
  # @return [String] html of tag
  def vue_content_tag_for_autoloader(name, content, content_or_options_with_block = nil, options = nil, escape = true, &block)
    if content_or_options_with_block.instance_of?(String)
      options["v-html"] = content_or_options_with_block
      content_or_options_with_block = eval(content_or_options_with_block)
    end
    vue_content_tag(name, content_or_options_with_block, options, escape, &block)
  end
end