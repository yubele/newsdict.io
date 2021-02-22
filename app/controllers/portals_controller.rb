class PortalsController < ApplicationController
  include Api::ContentsControllerConcern
  # List the data of `Contents`
  def show
    if params.has_key?(:category)
      @rss_path = category_rss_path(params[:category])
      @category_name = params[:category]
    else
      tags = CollectTag.cloud(limit: 3)
      params[:tag] = tags.pluck(:name).join(',')
      @rss_path = rss_path
      @category_name = I18n.t(:top_page)
    end
    @contents = JSON.parse(contents(**params.permit([:sort, :category, :tag, :search]).to_hash.symbolize_keys), object_class: OpenStruct)
  end
  # Page
  # @param url_suffix
  def page(url_suffix)
    @page = Page.find_by(url_suffix: url_suffix)
    @title = @page.title
  end
end