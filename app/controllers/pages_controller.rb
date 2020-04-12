class PagesController < ApplicationController
  include Api::ContentsControllerConcern
  # show
  def show
    @contents = contents(**params.permit([:sort, :category]).to_hash.symbolize_keys)
  end
end