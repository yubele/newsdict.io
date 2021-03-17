class ContentsController < ApplicationController
  include Api::ContentsControllerConcern
  # Show content
  # @params [BSON::ObjectId]
  def show(id)
    @content = Content.contents.find_by(id: id)
    raise ActionController::RoutingError.new('Not Found') if @content.nil?
    @related_contents = Array.new
    @content.tags.each do |tag|
      @related_contents.concat(contents(tag: tag))
    end
    @contents = Content.contents(name: @content.source.name)
      .sortable
      .page(@content.page_num({
        by: :updated_at,
        order: :desc}))
  end
end