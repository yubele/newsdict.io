module ThemeConcern
  extend ActiveSupport::Concern
  def prepare_save 
    if is_active == true
      Theme.where(is_active: true).update(is_active: false)
    end
  end
  class_methods do
  end
end