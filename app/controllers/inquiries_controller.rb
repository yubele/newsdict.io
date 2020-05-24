class InquiriesController < ApplicationController
  def show
    @title = I18n.t('inquiry');
    @noindex = true
    @resource = Inquiry.new
  end
  def create
    @noindex = true
    @resource = Inquiry.new(params.require(:inquiry).permit(:name, :mailaddress, :inquiry))
    if !session[:inquiry_authenticity_token].include?(params[:authenticity_token]) && @resource.save
      # Double posting measures
      session[:inquiry_authenticity_token] = Array.new unless session.key?(:inquiry_authenticity_token)
      session[:inquiry_authenticity_token].push(params[:authenticity_token])
      @title = I18n.t('inquiries.confirm.thank_you_for_inquiry');
      render :confirm
    else
      render :show
    end
  end
end