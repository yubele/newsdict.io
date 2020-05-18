class Configs::Theme < Config
  before_save do
    if is_active == true
      self.class.where(is_active: true).update(is_active: false)
    end
  end
  field :name, type: String
  field :description, type: String
  field :is_active, type: Boolean, default: false
  validates :name, uniqueness: true
end