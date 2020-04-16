class InquiriesController < ApplicationController
  def show
    @resource = Inquiry.new
  end
  def create
    @resource = Inquiry.new(params.require(:inquiry).permit(:name, :mailaddress, :inquiry))
    binding.pry
    if !session[:inquiry_authenticity_token].include?(params[:authenticity_token]) && @resource.save
      # Double posting measures
      session[:inquiry_authenticity_token] = Array.new unless session.key?(:inquiry_authenticity_token)
      session[:inquiry_authenticity_token].push(params[:authenticity_token])
      render :confirm
    else
      render :show
    end
  end
end