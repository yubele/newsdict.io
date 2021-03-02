class ErrorsController < ApplicationController
  def not_found
    @contents = JSON.parse(contents, object_class: OpenStruct)
    respond_to do |format|
      format.all {
        render 'errors/exceptions_app',
        content_type: 'text/html',
        status: 404,
        layout: 'application' }
    end
  end
end