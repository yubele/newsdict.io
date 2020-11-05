class Portals::SourcesController < PortalsController
  include Api::ContentsControllerConcern
  # Show source page.
  def show(id)
    @source = Source.find_by(id: id)
    raise ActionController::RoutingError.new('Not Found') if @source.nil?
    @contents = Content.where(source_id: id).sortable.page(1)
    @content = @contents.order_by(created_at: :desc).first
  end
end