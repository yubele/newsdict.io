class ContentsController < ApplicationController
  include Api::ContentsControllerConcern
  # Show content
  # @params [BSON::ObjectId]
  def show(id)
    @content = Content.find_by(id: id)
    @contents = Contents::Web.contents(name: @content.source.name)
      .order_by(created_at: :desc)
      .page(@content.page_num({
        by: :created_at,
        order: :desc}))
  end
end