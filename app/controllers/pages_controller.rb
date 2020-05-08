class PagesController < ApplicationController
  include Api::ContentsControllerConcern
  # List the data of `Contents`
  def show
    @contents = contents(**params.permit([:sort, :category]).to_hash.symbolize_keys)
  end
end