class DashboardsController < ApplicationController
  include Api::ContentsControllerConcern
  before_action :init_vars
  def init_vars
    @per_page = Newsdict::Application.config.paper_item_limit
    @column_number = Newsdict::Application.config.paper_column_number
  end
  # Dashboard of authorized user.
  def show
    time = Time.strptime('20200501', '%Y%m%d')
    @paper = Paper.new
    @paper.user = User.find_by(email: ENV['ADMIN_USER_EMAIL'])
    @contents = Contents::Web.contents.sortable(params[:sort]).gte(:created_at => time.midnight).lte(:created_at => time.end_of_day).page(params[:page])
    @paper.title = I18n.t('paper.one_day.title', date: I18n.l(time, format: :only_date))
    render :show
  end
end