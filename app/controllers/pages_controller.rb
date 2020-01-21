class PagesController < ApplicationController
  include Api::ContentsControllerConcern
  # show
  def show
    @contents = contents(limit: 25)
  end
end