class PapersController < ApplicationController
  before_action :init_vars
  def init_vars
    @per_page = Newsdict::Application.config.paper_item_limit
    @column_number = Newsdict::Application.config.paper_column_number
  end
  def show(id)
    @paper = Paper.find_by(id: id)
    @contents = Content.contents.sortable(params[:sort]).in(@paper.contents).page(params[:page])
  end
  def term(from_date, to_date)
    from_time = Time.strptime(from_date, '%Y%m%d').midnight
    to_time = Time.strptime(to_date, '%Y%m%d').end_of_day
    @paper = Paper.new
    @paper.user = User.find_by(email: ENV['ADMIN_USER_EMAIL'])
    @contents = Content.contents.sortable(params[:sort]).gte(:created_at => from_time).lte(:created_at => to_time).page(params[:page])
    @paper.title = @title = I18n.t('paper.term.title', from_date: I18n.l(from_time, format: :only_date), to_date: I18n.l(to_time, format: :only_date))
    render :show
  end
  def one_day(date)
    time = Time.strptime(date, '%Y%m%d')
    @paper = Paper.new
    @paper.user = User.find_by(email: ENV['ADMIN_USER_EMAIL'])
    @contents = Content.contents.sortable(params[:sort]).gte(:created_at => time.midnight).lte(:created_at => time.end_of_day).page(params[:page])
    @paper.title = I18n.t('paper.one_day.title', date: I18n.l(time, format: :only_date))
    render :show
  end
end