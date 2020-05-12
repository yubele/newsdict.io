class Api::V1::ContentsController < ApplicationController
  include Api::ContentsControllerConcern
  # show
  #  /api/v1/contents.json?skip=[\d]+&limit=[\d]+&sort=(desc|asc)&category=xxx
  def show
    respond_to do |format|
      format.json { render json: contents(params.permit(:skip, :limit, :sort, :category).to_hash.symbolize_keys) }
    end
  end
end