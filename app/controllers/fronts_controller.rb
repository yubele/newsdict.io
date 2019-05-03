class FrontsController < ApplicationController
  def index
    @contents = Contents::Web.order_by(updated_at: :desc).limit(10)
  end
end