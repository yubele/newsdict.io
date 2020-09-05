class Api::V1::ContentsController < ApplicationController
  include Api::ContentsControllerConcern
  # show
  #  /api/v1/contents.json?skip=[\d]+&limit=[\d]+&sort=(desc|asc)&category=xxx
  def show
    render json: contents(params.permit(:skip, :limit, :sort, :category, :tag).to_hash.symbolize_keys)
  end
end