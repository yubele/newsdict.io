class InquiriesController < ApplicationController
  # Show inquiries
  def show
    @title = I18n.t('inquiry');
    @noindex = true
    @resource = Inquiry.new
  end
  # Create inquiry
  def create
    @noindex = true
    @resource = Inquiry.new(params.require(:inquiry).permit(:name, :mailaddress, :inquiry, :url))
    if verify_recaptcha(model: @resource) && @resource.save
      # Double posting measures
      session[:inquiry_authenticity_token] = Array.new unless session.key?(:inquiry_authenticity_token)
      session[:inquiry_authenticity_token].push(params[:authenticity_token])
      @title = I18n.t('inquiries.confirm.thank_you_for_inquiry');
      render :confirm
    else
      render action: :show, **params.require(:inquiry).permit(:url)
    end
  end
  # Rquest removing.
  # @param [String] id Request content id
  # @param [String] authenticity_token reCaptcha token
  def request_removing(id:, authenticity_token:)
    content = Content.find_by(id: id)
    url = content.expanded_url
    if verify_recaptcha(action: 'request_removing', secret_key:  Configs::Global.find_by(key: :recaptcha_v3_secret_key).value)
      filter = ::Filters::HiddenContent.new({
        exclude_url: url
      })
      filter.save
      redirect_to action: :show, url: "https://#{request.host}#{content_path(content)}"
    else
      render status: 503
    end
  end
end