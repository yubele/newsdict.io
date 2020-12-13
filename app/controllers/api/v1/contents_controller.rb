class Api::V1::ThemesController < ApplicationController
  include Api::ThemessControllerConcern
  # show
  #  /api/v1/contents.json?skip=[\d]+&limit=[\d]+&sort=(desc|asc)&category=xxx
  def show
    render json: contents(params.permit(:skip, :limit, :sort, :category, :tag).to_hash.symbolize_keys)
  end
end