class Configs::Token < Config
  before_save do
    if is_default == true
      self.class.where(is_default: true).update(is_default: false)
    end
  end
  field :is_default, type: Boolean, default: false
end