class FrontsController < ApplicationController
  # index
  def index
    @contents = Contents::Web.contents
  end
end