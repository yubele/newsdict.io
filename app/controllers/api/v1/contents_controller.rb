class Api::V1::ContentsController < ApplicationController
  include Api::ContentsControllerConcern
  # show
  # @param [Integer] skip
  # @param [Integer] limit
  def show
    respond_to do |format|
      format.json { render json: contents(skip: params["skip"], limit: params["limit"]) }
    end
  end
end