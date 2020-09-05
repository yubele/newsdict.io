class DashboardsController < ApplicationController
  include Api::ContentsControllerConcern
  # Dashboard of authorized user.
  def show
    @contents = Contents::Web.contents.sortable(params[:sort]).page(params[:page])
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