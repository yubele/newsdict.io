class ContentsController < ApplicationController
  include Api::ContentsControllerConcern
  # Show content
  # @params [BSON::ObjectId]
  def show(id)
    @content = Content.find_by(id: id)
    @contents = Contents::Web.contents(name: @content.source.name)
      .sortable
      .page(@content.page_num({
        by: :updated_at,
        order: :desc}))
  end
end