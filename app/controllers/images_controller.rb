class ImagesController < ApplicationController
  # index
  def index
    blob = Contents::Web.find(params[:id]).image_blob
    send_data blob.data, :type => 'image', :disposition => 'inline'
  end
end