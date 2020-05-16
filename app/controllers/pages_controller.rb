class PagesController < ApplicationController
  include Api::ContentsControllerConcern
  # List the data of `Contents`
  def show
    @have_rss = true
    @category_name = params.has_key?(:category) ? params[:category] : I18n.t(:top_page) 
    @contents = contents(**params.permit([:sort, :category]).to_hash.symbolize_keys)
  end
end