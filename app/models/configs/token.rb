class Configs::Token < Config
  before_save do
    if is_default == true
      self.class.where(is_default: true).update(is_default: false)
    end
  end
  field :is_default, type: Boolean, default: false
  # Create message
  # @param [Contents::Web] contents
  # @return [String] body
  def create_message(contents)
    body = <<EOS
#{text}
----
EOS
    contents.each do |content|
      body << "#{content.title}\n"
      body << "   #{content.expanded_url}\n"
    end
    body.chomp
  end
end