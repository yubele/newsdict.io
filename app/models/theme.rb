class Theme < ApplicationRecord
  include ThemeConcern
  include Mongoid::Document
  before_save :prepare_save
  field :name, type: String
  field :description, type: String
  field :is_active, type: Boolean, default: false
  validates :name, uniqueness: true
end