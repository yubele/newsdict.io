class ImagesController < ApplicationController
  # index
  def index
    if content = Contents::Web.find(params[:id])
      if content.image_blob
        send_data content.image_blob.data, :type => 'image', :disposition => 'inline'
      else
        render html: content.image_svg
      end
    else
      render :status => 404
    end
  end
end