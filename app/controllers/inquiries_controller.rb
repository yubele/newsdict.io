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
      @title = I18n.t('inquiries.confirm.thank_you_for_inquiry')
      # Hook
      message =<<~EOF
        #{t('.your_name')}: #{@resource.name}
        #{t('.your_mailaddress')}: #{@resource.mailaddress}
        #{t('.inquiry')}: #{@resource.inquiry}
      EOF
      Configs::Hook.trigger(:receive_form, message)
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
    request_url = "https://#{request.host}#{content_path(content)}"
    url = content.expanded_url
    if verify_recaptcha(action: 'request_removing', secret_key:  Configs::Global.find_by(key: :recaptcha_v3_secret_key).value)
      filter = ::Filters::HiddenContent.new({
        exclude_url: url
      })
      filter.save
      # Hook
      message =<<~EOF
        url: #{request_url}
        expanded url: #{url}
      EOF
      Configs::Hook.trigger(:requested_removing, message)
      redirect_to action: :show, url: request_url
    else
      render status: 503
    end
  end
end