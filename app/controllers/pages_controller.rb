class PagesController < ApplicationController
  include Api::ContentsControllerConcern
  def show
    @contents = contents(**params.permit([:sort, :category]).to_hash.symbolize_keys)
  end
  def content
    @content = Content.find_by(id: params[:id])
  end
end