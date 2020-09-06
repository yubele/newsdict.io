class DashboardsController < ApplicationController
  include Api::ContentsControllerConcern
  # Dashboard of authorized user.
  def show
    @contents = JSON.parse(contents(**params.permit([:sort, :category, :tag]).to_hash.symbolize_keys), object_class: OpenStruct)
    render :show
  end
  # Search content
  # @param [String] keyword
  def search(keyword)
    @contents = Contents::Web.search_by_mixed(keyword).contents.page(params[:page])
    render :show
  end
  # Search content by tag
  # @param [String] keyword
  def tag(keyword)
    @contents = Contents::Web.search_by_tag(keyword).page(params[:page])
    render :show
  end
end