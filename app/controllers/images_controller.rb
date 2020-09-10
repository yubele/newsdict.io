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
  # View user's icon
  # @params [BSON::ObjectId] id
  def user_icon(id)
    source = Source.find(id)
    if source.icon
      send_data source.icon_blob.data, :type => 'image', :disposition => 'inline'
    else
      render :status => 404
    end
  end
end