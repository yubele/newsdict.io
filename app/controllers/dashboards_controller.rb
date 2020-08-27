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
    @contents = Contents::Web.contents.search_by_mixed(keyword).page(params[:page])
    @paper.title = I18n.t('paper.one_day.title', date: I18n.l(time, format: :only_date))
    render :show
  end
end