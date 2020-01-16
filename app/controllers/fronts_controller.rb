class FrontsController < ApplicationController
  # index
  def index
    @contents = Contents::Web.contents.sortable(params["sort"])
  end
end