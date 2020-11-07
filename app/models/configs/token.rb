class Configs::Token < Config
  before_save do
    if is_default == true
      self.class.where(is_default: true).update(is_default: false)
    end
  end
  field :is_default, type: Boolean, default: false
  # Create message
  # @param [Content] contents
  # @return [String] body
  def create_message(contents)
    body = <<EOS
#{text}
----
EOS
    if contents.is_a?(String)
      body << contents
    else
      contents.each do |content|
        body << "#{content.title}\n"
        body << "   #{content.expanded_url}\n"
      end
    end
    body.chomp
  end
end