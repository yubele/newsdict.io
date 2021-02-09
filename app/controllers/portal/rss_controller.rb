class Portal::RssController < PortalsController
  layout false
  # Feed the data of `Contents`
  def show
    super
    @rss = RSS::Maker.make("atom") do |maker|
      maker.channel.author = User.find_by(email: ENV['ADMIN_USER_EMAIL']).username
      maker.channel.about = request.url
      maker.channel.title = I18n.t('rss.title', name: @category_name)
      maker.channel.updated = Time.now.to_s
      @contents.each do |content|
        maker.items.new_item do |item|
          item.link = "#{request.protocol}#{request.host_with_port}#{content_path(content.id)}"
          item.title = content.title
          item.author = content.user.username
          item.updated = content.updated_at
        end
      end
    end
  end
end