class FrontsController < ApplicationController
  # index
  def index
    @contents = Contents::Web.order_by(updated_at: :desc).limit(10)
  end
end