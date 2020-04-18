class PagesController < ApplicationController
  include Api::ContentsControllerConcern
  # List the data of `Contents`
  def show
    @contents = contents(**params.permit([:sort, :category]).to_hash.symbolize_keys)
  end
  # Show data of `Content`
  def content
    @content = Content.find_by(id: params[:id])
  end
  def paper
    @title = 'paper'
    @max_column = 4
    # @todo: implements
    @paper = Paper.new
    @paper.title = 'test'
    @paper.description = 'test description'
    @paper.user = User.first
    Contents::Web.gte( :created_at => Time.now.ago(7.days) ).limit(16).each do |content|
      @paper.contents << content
    end
  end
end