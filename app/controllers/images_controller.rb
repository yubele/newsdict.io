class ImagesController < ApplicationController
  # index
  def index
    if content = Contents::Web.find(params[:id])
      if content.image_blob
        send_data content.image_blob.data, :type => 'image', :disposition => 'inline'
      elsif content.image_svg
        send_data content.image_svg, type: 'image/svg+xml'
      else
        render :status => 404
      end
    else
      render :status => 404
    end
  end
end