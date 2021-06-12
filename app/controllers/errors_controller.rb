class ErrorsController < ApplicationController
  def not_found
    @related_contents = contents
    respond_to do |format|
      format.all {
        render 'errors/exceptions_app',
        content_type: 'text/html',
        status: 404,
        layout: 'application' }
    end
  end
end