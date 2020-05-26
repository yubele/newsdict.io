class TimelinesController < ApplicationController
  include Api::ContentsControllerConcern
  # List the data of `Contents`
  def show
    if params.has_key?(:category)
      @rss_path = category_rss_path(params[:category])
      @category_name = params[:category]
    else
      @rss_path = rss_path
      @category_name = I18n.t(:top_page) 
    end
    @contents = contents(**params.permit([:sort, :category]).to_hash.symbolize_keys)
  end
end