class ContentsController < ApplicationController
  include Api::ContentsControllerConcern
  def show
    @content = Content.find_by(id: params[:id])
  end
end