class ContentsController < ApplicationController
  include Api::ContentsControllerConcern
  # Show content
  # @params [BSON::ObjectId]
  def show(id)
    @content = Content.contents.find_by(id: id)
    raise ActionController::RoutingError.new('Not Found') if @content.nil?
    @contents = Content.contents(name: @content.source.name)
      .sortable
      .page(@content.page_num({
        by: :updated_at,
        order: :desc}))
  end
end