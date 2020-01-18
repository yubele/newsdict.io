class FrontsController < ApplicationController
  # index
  def index
    @contents = Contents::Web.contents.sortable(params["sort"]).limit(25)
  end
end