module VueHelper
  include Rails.application.routes.url_helpers

  # Convert content for vue
  # @param [Boolean] is_vue Vue contents
  # @param [String] name String of element
  # @param [OpenStruct] content (Need for `eval`)
  # @param [Boolean] is_bind When setting to bind attribute
  # @return [String] converted content
  def vue_content(is_vue, name, content, is_bind = false)
    if is_vue && is_bind
      name
    elsif is_vue
      "{{#{name}}}"
    else
      eval(name)
    end
  end

  # Return content path for vuejs
  # @param [Boolean] is_vue Vue content
  # @param [OpenStruct] content
  # @return [String] converted content
  def vue_content_path(is_vue, content)
    if is_vue
      "'/contents/' + content.id + '/'"
    else
      content_path(content.id)
    end
  end

  # Return image path for vuejs
  # @param [Boolean] is_vue Vue content
  # @param [OpenStruct] content
  # @return [String] converted content
  def vue_img_path(is_vue, content)
    if is_vue
      "'/img/' + content.id + '/'"
    else
      img_path(content.id)
    end
  end

  # Return icon path for vuejs
  # @param [Boolean] is_vue Vue content
  # @param [OpenStruct] content
  # @return [String] converted content
  def vue_icon_path(is_vue, content)
    if is_vue
      "'/user_icon/' + content.source.id + '/'"
    else
      user_icon_path(content.source.id)
    end
  end

  # Return source path for vuejs
  # @param [Boolean] is_vue Vue content
  # @param [OpenStruct] content
  # @return [String] converted content
  def vue_source_path(is_vue, content)
    if is_vue
      "'/sources/' + content.source.id + '/'"
    else
      source_path(content.source.id)
    end
  end

  # Return image path of css style for vuejs
  # @param [Boolean] is_vue Vue content
  # @param [OpenStruct] content
  # @return [String] converted content
  def vue_backgrond_img_path(is_vue, content)
    if is_vue
      "'background-image: url(/img/' + content.id + '/)'"
    else
      "background-image: url(#{img_path(content.id)})"
    end
  end
end